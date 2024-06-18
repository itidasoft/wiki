DECLARE @libname varchar( 250 ), @code char( 10 );
SELECT @libname= 'Внешние API';
SELECT @code= ISNULL( ( SELECT MIN( code ) FROM sprfunctionslib WHERE name= @libname ), '' );
DELETE FROM sprfunctionslib WHERE name= @libname;
INSERT INTO sprfunctionslib (CODE,NAME,ALIAS) VALUES ( @code, 'Внешние API','eapi');
SELECT @code= code FROM sprfunctionslib WHERE name=@libname;
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'ПроверкаТелефонаКлиента','ПРОВЕРКАТЕЛЕФОНАКЛИЕНТА (ТЕЛЕФОН, НОМЕРКАРТЫ, ОПЕРАЦИЯ)','// Параметры
// Телефон - введенный телефон клиента
// Операция - 1 проверка наличия и добавление, если нет такого
//          - 2 изменение имеющихся данных

IF ( ПУСТО( НОМЕРКАРТЫ ) && ПУСТО( ТЕЛЕФОН )  )
	RETURN false;
	
ТЕЛЕФОН			= eapi.НОРМАЛИЗОВАННЫЙТЕЛЕФОН( ТЕЛЕФОН );
// Если не указан телефон, то по номеру карты ищем клиента и его номер  телефона
IF ( ПУСТО( ТЕЛЕФОН ) )
{
	ТЕЛЕФОН		= ЗАПРОС( "SELECT telefon FROM sprmclient 
						   WHERE cardn = ''" + STDF( НОМЕРКАРТЫ ) + "'' OR 
								 card IN ( SELECT code FROM sprmcard WHERE cardn = ''" + STDF( НОМЕРКАРТЫ ) + "'' ) OR
								 code IN ( SELECT client FROM sprmcard WHERE cardn = ''" + STDF( НОМЕРКАРТЫ ) + "'' )");
}

// Если введенного телефона нет в спраочнике, то запрашиваем данные из внешней системы 
ИнформацияОКарте	= eapi.PBONUS_ПолучениеИнформацииОКарте( НОМЕРКАРТЫ, ТЕЛЕФОН );
IF ( ПУСТО( ИнформацияОКарте ) )
{
	IF ( Операция == 1 )
	{
		IF ( СООБЩЕНИЕ( "Телефон " + Телефон + " не найден в базе данных." + CHR( 13 ) + "Добавить нового клиента?",  "Проверка номера телефона", 4  ) != 6 )
			RETURN "";
	}
	ELSE IF ( Операция == 2 )
	{
		СООБЩЕНИЕ( "Телефон " + Телефон + " не найден в базе данных.", "Проверка номера телефона", 0 );
		RETURN "";
	}
}
ELSE IF ( Операция == 1 )
{
	RETURN ПОЛЕ_JSON( ИнформацияОКарте, "card_number", "" );
}

JSONTOVARS( ИнформацияОКарте );

ПАРАМЕТРЫ			= eapi.ТЕКСТПАРАМЕТРОВ( );//ФАЙЛПРОЧИТАТЬ( "c:\trash\pbparams.txt", "S", -1 );

ПРОЧИТАТЬНАСТРОЙКИ( "", "city_id,group_id,register_point,register_point_name, register_channel" );

IF ( ПУСТО( ПЕРЕМЕННАЯ( "card_number", "" ) ) )
	card_number		= НОМЕРКАРТЫ;
IF ( ПУСТО( ПЕРЕМЕННАЯ( "phone", "" ) ) )
	phone			= ТЕЛЕФОН;
IF ( ПУСТО( card_number ) )
	card_number		= phone;
	
ОТПРАВИТЬСООБЩЕНИЕ( _ДЕСКРИПТОРОКНА, _СООБЩЕНИЕВЫПОЛНИТЬКОМАНДУ, "ЗАПРОСПАРАМЕТРОВ", ПАРАМЕТРЫ );
IF ( !_РЕЗУЛЬТАТВВОДАПАРАМЕТРОВ ) 
	RETURN "";
	
СОХРАНИТЬНАСТРОЙКИ( "", "city_id,group_id,register_point,register_point_name,register_channel" );

// Добавляем / изменяем данные в справочнике влиентов владельцев карт и в PBONUS
phone				= ЗАМЕНИТЬ( ЗАМЕНИТЬ( ЗАМЕНИТЬ( ЗАМЕНИТЬ( ЗАМЕНИТЬ( phone, "(", "" ), ")", "" ), "+", "" ), " ", "" ), "-", "" );
ТЕЛЕФОН				= phone;
НОМЕРКАРТЫ			= СЖАТЬПРОБЕЛЫ( card_number );
КОДКЛИЕНТА 			= ЗАПРОС( "SELECT code FROM sprmclient WHERE telefon = ''" + STDF( ТЕЛЕФОН ) + "''" );
КОДКАРТЫ			= ЗАПРОС( "SELECT code FROM sprmcard WHERE cardn= ''" + STDF( НОМЕРКАРТЫ ) + "''" );
ИМЯКЛИЕНТА			= STDF( СЖАТЬПРОБЕЛЫ( surname ) + СЖАТЬПРОБЕЛЫ( " " + СЖАТЬПРОБЕЛЫ( name ) + " " + СЖАТЬПРОБЕЛЫ( middle_name ) ) + " " + ТЕЛЕФОН );
СЧЕТЧИКБОНУСОВ		= ЗАПРОС( "SELECT code FROM sprbonus WHERE bonusalias= ''PBONUS''" );

IF ( ПУСТО( КОДКАРТЫ ) && !ПУСТО( НОМЕРКАРТЫ ) )
{
	IF ( !ДОБАВИТЬКОНТЕКСТ( "INSERT INTO sprmcard ( code, name, ctext, cardn, card_type, bonus, str_date, end_date, counter, saldo ) 
							VALUES ( '''', ''" + ИМЯКЛИЕНТА + "'', ''Бонусная карта № " + STDF( card_number ) + "'', ''" + STDF( card_number ) + 
							"'', 1, ''" + СЧЕТЧИКБОНУСОВ + "'', ''20200101'', ''20991231'', " + STR( init_purchase_count ) + ", " + STR( init_payment_amount ) + " ) ", "ИД" ) )
	{
		СООБЩЕНИЕ( "Ошибка добавления карты клиента:" + CHR( 13 ) + _ERRORDESCRIPTION, "Проверка номера телефона" );
		RETURN "";
	}
	КОДКАРТЫ		= ЗАПРОС( "SELECT code FROM sprmcard WHERE identity_column= " + ИД.ident );
	УДАЛИТЬКОНТЕКСТ( "ИД" );
}

IF ( ПУСТО( КОДКЛИЕНТА ) )
{
	IF ( !ДОБАВИТЬКОНТЕКСТ( "INSERT INTO sprmclient ( name, ctext, shortname, telefon, cardn, card, email, sex, birthdate, f_sms, f_adv ) 
							 VALUES ( ''" + ИМЯКЛИЕНТА + "'', ''" + ИМЯКЛИЕНТА + "'', ''" + ИМЯКЛИЕНТА + "'', ''" + STDF( ТЕЛЕФОН ) + "'', ''" + STDF( card_number ) + "'', ''" + КОДКАРТЫ + "'',
									  ''" + STDF( email )+ "'', " + ЕСЛИ( gender == "femail", "1", "0" ) + ", ''" + DTOC( birth_date ) + "'',
									   " + ЕСЛИ( is_refused_receive_messages, "1", "0" ) + ", " + ЕСЛИ( is_refused_receive_emails, "1", "0" ) + " ) ", "ИД" ) )
	{
		СООБЩЕНИЕ( "Ошибка добавления карты клиента:" + CHR( 13 ) + _ERRORDESCRIPTION, "Проверка номера телефона" );
		RETURN "";
	}
	
	КОДКЛИЕНТА		= ЗАПРОС( "SELECT code FROM sprmclient WHERE identity_column= " + ИД.ident );
	УДАЛИТЬКОНТЕКСТ( "ИД" );
}

IF ( ПУСТО( КОДКЛИЕНТА ) )
{
	СООБЩЕНИЕ( "Не удалось добавить нового клиента в базу данных.", "Проверка номера телефона" );
	RETURN "";
}

// Если добавление кдиента, то отправляем запрос на добавление
Заголовки[ 0 ] 			= "Authorization: " + ALLTRIM( Токен );	
Заголовки[ 1 ] 			= "Content-Type: application/json; charset=utf-8";	
УспешноеПолучение 		= false;
СписокПолей 			= "phone referral_code card_number surname name middle_name birth_date gender email child1_birth_date child1_name child1_gender child2_birth_date
						   child2_name child2_gender child3_birth_date child3_name child3_gender child4_birth_date child4_name child4_gender register_channel register_point
						   group_id city_id phone_checked is_refused_receive_messages is_refused_receive_emails is_agreed_receive_electronic_receipt 
						   init_purchase_count init_payment_amount cashier_name " + ЕСЛИ( ПУСТО( ИнформацияОКарте ), " external_id", "" );
						   
external_id				= КОДКЛИЕНТА;
АдресСервера 			= "https://site-v2.apipb.ru";
АдресРесурса 			= ЕСЛИ( ПУСТО( ИнформацияОКарте ), "/buyer-register", "/buyer-edit" );
ОТВЕТ 					= EAPI.PBONUS_POSTЗАПРОС( АдресСервера, АдресРесурса, СФОРМИРОВАТЬ_VJSON( СписокПолей ), "Заголовки" );

RETURN ПОЛЕ_JSON( Ответ, "card_number", "" );
','',0,'',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_СкриптНачисления','ЛОКАЛЬНАЯ PBONUS_СКРИПТНАЧИСЛЕНИЯ (НОМЕРКАРТЫ)','Результат = 0;

IF ( МЕСТОВЫЗОВА == "ЗАПИСЬБОНУСА" AND _ОПЕРАЦИЯ != "ВОЗВРАТ" AND _ОПЕРАЦИЯ != "ВОЗВРАТПРИХОДА" )
{
	Результат 		= eapi.PBONUS_СовершениеПокупки( ИДЧЕКА, НОМЕРКАРТЫ, ВСЕГОБОНУСОВ );
}
ELSE IF	( МЕСТОВЫЗОВА == "ЗАПИСЬБОНУСА" AND ( _ОПЕРАЦИЯ == "ВОЗВРАТ" OR _ОПЕРАЦИЯ == "ВОЗВРАТПРИХОДА" ) )
	EAPI.PBONUS_УдалениеПокупки( ИДЧЕКА, _ИДЧЕКАОСНОВАНИЯ, НОМЕРКАРТЫ, true );
ELSE IF ( МЕСТОВЫЗОВА == "РАСЧЕТНАЧИСЛЕНИЙ" )
{
	Результат 		= eapi.PBONUS_РасчетПокупки( ИДЧЕКА, НОМЕРКАРТЫ, ВСЕГОБОНУСОВ );
}
ELSE IF ( МЕСТОВЫЗОВА == "РАСЧЕТСКИДКИ" )
	Результат 		= 0;
ELSE IF ( МЕСТОВЫЗОВА == "ОТМЕНАЧЕКА" )	
	EAPI.PBONUS_УдалениеПокупки( ИДЧЕКА, _ИДЧЕКАОСНОВАНИЯ, НОМЕРКАРТЫ, false );
	
RETURN Результат;','Функция выполняет скрипт начисления баллов на счетчик бонусов
Параметры:
НОМЕРКАРТЫ - номер карты, по которой производим начисление',1,'PBONUS.ОтправкаДанных',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_СовершениеПокупки','ЛОКАЛЬНАЯ PBONUS_СОВЕРШЕНИЕПОКУПКИ (ИДЕНТИФИКАТОРЧЕКА, НОМЕРКАРТЫ, СУММАБАЛЛОВ)','IF ( ПУСТО( ИДЕНТИФИКАТОРЧЕКА ) )
{
	СООБЩЕНИЕ("Не определен идентификатор чека. " + CHR(13) + CHR(10) + "Отравка чека в PBONUS проведена не будет.", "PBONUS - отправка чека");
	RETURN false;
}

IF  ( ПУСТО( НОМЕРКАРТЫ ) ) 
{
	//СООБЩЕНИЕ("Не определен номер карты. " + CHR(13) + CHR(10) + "Отравка чека в PBONUS проведена не будет.", "PBONUS - отправка чека");
	RETURN false;
}

Токен = EAPI.PBONUS_TOKEN( НОМЕРКАРТЫ );
IF ( ПУСТО( Токен ) )
{
	СООБЩЕНИЕ("Не определен токен PBONUS. " + CHR(13) + CHR(10) + "Отравка чека в PBONUS проведена не будет.", "PBONUS - отправка чека");
	RETURN false;
}

//выберем данные шапки документа
ДОБАВИТЬКОНТЕКСТ( "SELECT rid, date, firm, cur, sklad, kskod, client, partner, cardnumber, checktype, 
						  subtotal, bonus, chequediscount, chequediscount_prc, telemail, author, shiftnumber, chequenumber, comment
				   FROM chequelist WHERE identity_column = ''" + ИДЕНТИФИКАТОРЧЕКА + "''", "ДанныеДокумента" );
ВЫБРАТЬКОНТЕКСТ( "ДанныеДокумента" );

ПРОЧИТАТЬНАСТРОЙКИ( "", "city_id,group_id,register_point,register_point_name, register_channel" );

phone					= eapi.НОРМАЛИЗОВАННЫЙТЕЛЕФОН( ДанныеДокумента.telemail );
sale_point_id			= ПЕРЕМЕННАЯ( "register_point", "" );
sale_point				= ПЕРЕМЕННАЯ( "register_point_name", "" );
sale_channel			= "Наличные";
promocode				= "";
external_purchase_id	= ДанныеДокумента.rid;
cashier_name			= ДанныеДокумента.author;
discount				= ДанныеДокумента.chequediscount;
write_off_bonus			= ДанныеДокумента.bonus;

//  "sale_channel": "'' + sale_channel + ''",

ТекстЗапроса			= ''
{
  "phone": "'' + phone + ''",
  "sale_point_id": "'' + sale_point_id + ''",
  "sale_point": "'' + sale_point + ''",
  "promocode": "'' + promocode + ''",
  "external_purchase_id": "'' + external_purchase_id + ''",
  '' + ДАННЫЕ_JSON( "cashier_name", cashier_name ) + '',
  "waiters_names": [ "" ],
  "discount": '' + СТРОКА( discount, 10, 2 ) + '',
  "write_off_bonus": '' + СТРОКА( write_off_bonus ) + '',
  "items": ['';
  
 СписокТоваров	= "";
 ДОБАВИТЬКОНТЕКСТ( "SELECT * FROM chequespec WHERE ic = " + ИДЕНТИФИКАТОРЧЕКА , "СписокСтрок" );
 WHILE ( !КОНЕЦКОНТЕКСТА( "СписокСтрок" ) )
 {
	IF ( !ПУСТО( СписокТоваров ) )
		СписокТоваров	+= '','';
		
	СписокТоваров	+= ''{
      '' + ДАННЫЕ_JSON( "name", СписокСтрок.nnname ) + '',
      "external_item_id": "'' + СписокСтрок.nn + ''",
      "amount": '' + СТРОКА( СписокСтрок.summa_wd, 10, 2 ) + '',
      "quantity": '' + СТРОКА( СписокСтрок.kolp, 10, 3 ) + '',
      "discount": '' + СТРОКА( СписокСтрок.summa - СписокСтрок.summa_wd, 10, 2 ) + '',
      "type": "product",
      "groups": [ ],
      "tags": [ ]
    }'';
	ПРОПУСТИТЬ( 1, "СписокСтрок" );
}
ТекстЗапроса	+= СписокТоваров + ''
  ],
  "purchase_status": "approved" }'';

УДАЛИТЬКОНТЕКСТ( "СписокСтрок" );
УДАЛИТЬКОНТЕКСТ( "ДанныеДокумента" );

УспешноеВыполнение	= false;

АдресСервера		= "https://site-v2.apipb.ru";
АдресРесурса		= "/purchase";

Заголовки[ 0 ] 		= "Authorization: " + ALLTRIM( Токен );	
Заголовки[ 1 ]		= "Content-Type: application/json; charset=utf-8";	
	
ОТВЕТ 				= EAPI.PBONUS_POSTЗАПРОС( АдресСервера, АдресРесурса, ТекстЗапроса, "Заголовки" );

IF ( !ПУСТО( ОТВЕТ ) AND ОТВЕТ != false )
	УспешноеВыполнение = ПОЛЕ_JSON( ОТВЕТ, "success", false );

Результат			= 0;
IF ( УспешноеВыполнение == true || УспешноеВыполнение == "true" )
{
	ЗАПРОС( "UPDATE chequelist SET external_id = ''" + ПОЛЕ_JSON( ОТВЕТ, "purchase_id", '''' ) + "'' WHERE rid = ''" + external_purchase_id + "''" );
	УспешноеВыполнение 	= true;
	Результат			= ЧИСЛО( ПОЛЕ_JSON( ОТВЕТ, "total_write_on_bonus", 0.00 ) );
		
	СимвПС 				= CHR( 13 ) + CHR( 10 );
	ТекстСообщения 		= "Данные успешно переданы в PBonus." + СимвПС;
	ТекстСообщения 		+= "Начислено бонусов: " + STR( ПОЛЕ_JSON( ОТВЕТ, "total_write_on_bonus", 0 ), 10, 2 ) + СимвПС;
	ТекстСообщения 		+= "Списано бонусов:   " + STR( ПОЛЕ_JSON( ОТВЕТ, "total_write_off_bonus", 0 ), 10, 2 ) + СимвПС;
	ТекстСообщения 		+= "Баланс карты:      " + STR( ПОЛЕ_JSON( ОТВЕТ, "balance", 0 ), 10, 2 ) + СимвПС;
	СООБЩЕНИЕ( "font:{courier, 14, 0, 0}" + ТекстСообщения, "PBONUS - результат продажи." );
}
RETURN Результат;

','Функция осуществляет отправку запроса совершения покупки со списанием или без списания баллов
Параметры:
ИДЕНТИФИКАТОРЧЕКА - идентификатор чека в программе Айтида, по которому будет строиться структура чека для отправки
НОМЕРКАРТЫ - номер карты, по которой производим начисление
СУММАБАЛЛОВ - сумма списываемых баллов',1,'PBONUS.ОтправкаДанных',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_УдалениеПокупки','ЛОКАЛЬНАЯ PBONUS_УДАЛЕНИЕПОКУПКИ (ИДЕНТИФИКАТОРЧЕКА, ИДЕНТИФИКАТОРОСНОВАНИЯ, НОМЕРКАРТЫ, ЭТОВОЗВРАТ)','IF ( ПУСТО( ИДЕНТИФИКАТОРЧЕКА ) )
{
	СООБЩЕНИЕ("Не определен идентификатор чека. " + CHR(13) + CHR(10) + "Отравка операции отмены в PBONUS проведена не будет.", "PBONUS - отправка отмены операции");
	RETURN false;
}

IF ( ПУСТО( ИДЕНТИФИКАТОРОСНОВАНИЯ ) AND ЭТОВОЗВРАТ == true )
{
	СООБЩЕНИЕ("Не определен идентификатор чека основания. " + CHR(13) + CHR(10) + "Отравка операции отмены в PBONUS проведена не будет.", "PBONUS - отправка отмены операции");
	RETURN false;
}

IF ( ПУСТО( НОМЕРКАРТЫ ) ) 
{
	//СООБЩЕНИЕ("Не определен номер карты. " + CHR(13) + CHR(10) + "Отравка операции отмены в PBONUS проведена не будет.", "PBONUS - отправка отмены операции");
	RETURN false;
}

Токен 			= EAPI.PBONUS_TOKEN( НОМЕРКАРТЫ );
IF ( ПУСТО( Токен ) )
{
	СООБЩЕНИЕ("Не определен токен PBONUS. " + CHR(13) + CHR(10) + "Отравка операции отмены в PBONUS проведена не будет.", "PBONUS - отправка отмены операции");
	RETURN false;
}

//_ЧЕКДЛЯОТМЕНЫ = ЗАПРОС("SELECT identity_column FROM chequelist WHERE rid = ''" + ИДЕНТИФИКАТОРОСНОВАНИЯ + "''");
IF ( ЭТОВОЗВРАТ == true )
{
	purchase_id	= ЗАПРОС( "	SELECT external_id, rid FROM chequelist WHERE rid = ''" + ИДЕНТИФИКАТОРОСНОВАНИЯ + "''", "external_id" );

					
}
ELSE
{
	purchase_id	= ЗАПРОС( "	SELECT external_id, rid FROM chequelist WHERE identity_column = ''" + ИДЕНТИФИКАТОРЧЕКА + "''" );
}
external_id		= ЗАПРОС( "", "rid" );

ТекстЗапроса	= "{""purchase_id"": """ + purchase_id + """, ""external_purchase_id"": """ + external_id + """ }";


УспешноеВыполнение 	= false;
АдресСервера 		= "https://site-v2.apipb.ru";

АдресРесурса 		= "/cancel-purchase";

Заголовки[ 0 ] 		= "Authorization: " + ALLTRIM( Токен );	
Заголовки[ 1 ] 		= "Content-Type: application/json; charset=utf-8";	
	
ОТВЕТ				= EAPI.PBONUS_POSTЗАПРОС( АдресСервера, АдресРесурса, ТекстЗапроса, "Заголовки" );

IF ( !ПУСТО( ОТВЕТ ) AND ОТВЕТ  != false )
	УспешноеВыполнение = ПОЛЕ_JSON( ОТВЕТ_локардс, "success", false);

IF ( УспешноеВыполнение == false OR УспешноеВыполнение == "false" )
	СООБЩЕНИЕ("Не удалось удалить операцю продажи в системе PBONUS", "PBONUS - отправка отмены операции");

RETURN УспешноеВыполнение == true OR УспешноеВыполнение == "true";','Функция выполняет отправку запроса на удаление чека по идентификатору
Параметры:
ИДЕНТИФИКАТОРЧЕКА - идентификатор чека в программе Айтида, который выписан на основании отменяемого чека
ИДЕНТИФИКАТОРОСНОВАНИЯ - идентификатор чека в программе Айтида, по которому необходимо отменить операцию
НОМЕРКАРТЫ - номер карты, по которой производим начисление
ЭТОВОЗВРАТ - признак пробития чека возврата (true) или иного другого чека (false)',1,'PBONUS.ОтправкаДанных',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_КоличествоБонусов','ЛОКАЛЬНАЯ PBONUS_КОЛИЧЕСТВОБОНУСОВ (НОМЕРКАРТЫ, НОМЕРТЕЛЕФОНА, ВЫВОДИТЬСООБЩЕНИЕ)','ИнформацияОКарте 	= EAPI.PBONUS_ПолучениеИнформацииОКарте( НОМЕРКАРТЫ, НОМЕРТЕЛЕФОНА );
IF ( ПУСТО( ИнформацияОКарте ) ) 
	RETURN 0;

БалансКарты			= VAL( ПОЛЕ_JSON( ИнформацияОКарте, "balance_bonus_accumulated", 0 ) );

IF ( ПЕРЕМЕННАЯ( "ВЫВОДИТЬСООБЩЕНИЕ", false ) AND !ПУСТО( ИнформацияОКарте ) )
	EAPI.PBONUS_ВывестиСообщениеОКарте( ИнформацияОКарте );	

RETURN БалансКарты;','Функция получает количество бонусов по карте или по номеру телефона клиента
Параметры:
НОМЕРКАРТЫ - номер карты, по которой получаем информацию из системы
НОМЕРТЕЛЕФОНА - номер телефона в формате 7хххууухххх, по которому получаем информацию о карте из системы
ВЫВОДИТЬСООБЩЕНИЕ - признак необходимости вывода сообщения с данными карты',1,'PBONUS.ПолучениеДанных',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_ПолучениеИнформацииОКарте','ЛОКАЛЬНАЯ PBONUS_ПОЛУЧЕНИЕИНФОРМАЦИИОКАРТЕ (НОМЕРКАРТЫ, НОМЕРТЕЛЕФОНА)','IF ( ПУСТО( НОМЕРКАРТЫ ) AND ПУСТО( НОМЕРТЕЛЕФОНА ) )
{
	СООБЩЕНИЕ( "Не определен ни номер карты, ни номер телефона клиента. " + CHR(13) + CHR(10) + "Информация по карте загружена не будет.", "PBONUS - получение данных");
	RETURN "";
}

Токен 		= EAPI.PBONUS_TOKEN( НОМЕРКАРТЫ );
IF ( ПУСТО( Токен ) )
{
	СООБЩЕНИЕ("Не определен токен PBONUS. " + CHR( 13 ) + CHR( 10 ) + "Информация по карте загружена не будет.", "PBONUS - получение данных");
	RETURN "";
}

ИнформацияОКарте 		= "";
УспешноеПолучение 		= false;
АдресСервера 			= "https://site-v2.apipb.ru";
АдресРесурса			= "/buyer-info";
ТекстЗапроса			= "{""identificator"": """ + ЕСЛИ( ПУСТО( НОМЕРКАРТЫ ), НОМЕРТЕЛЕФОНА, НОМЕРКАРТЫ ) + """}";

Заголовки[ 0 ] 			= "Authorization: " + ALLTRIM( Токен );	
Заголовки[ 1 ] 			= "Content-Type: application/json; charset=utf-8";	
	
ОТВЕТ 					= EAPI.PBONUS_POSTЗАПРОС( АдресСервера, АдресРесурса, ТекстЗапроса, "Заголовки" );

IF ( !ПУСТО( ОТВЕТ ) )
{
	УспешноеПолучение 		= ПОЛЕ_JSON( ОТВЕТ, "success", false );
	IF ( УспешноеПолучение == true || УспешноеПолучение == "true" )
	{
		УспешноеПолучение 	= ПОЛЕ_JSON( ОТВЕТ, "is_registered", false );
		IF ( УспешноеПолучение == true || УспешноеПолучение == "true" )
			ИнформацияОКарте 	= ОТВЕТ;
	}
}

RETURN ИнформацияОКарте;','Функция получает информацию о карте по номеру карты или по номеру телефона
Параметры:
НОМЕРКАРТЫ - номер карты, по которой получаем информацию из системы
НОМЕРТЕЛЕФОНА - номер телефона, по которому получаем информацию о карте из системы',1,'PBONUS.ПолучениеДанных',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_ПолучитьЗначениеКарты','ЛОКАЛЬНАЯ PBONUS_ПОЛУЧИТЬЗНАЧЕНИЕКАРТЫ (НОМЕРКАРТЫ, НОМЕРТЕЛЕФОНА, ЧТОПОЛУЧАЕМ, ВЫВОДИТЬСООБЩЕНИЕ)','ИнформацияОКарте = EAPI.PBONUS_ПолучениеИнформацииОКарте( НОМЕРКАРТЫ, НОМЕРТЕЛЕФОНА );

IF ( ПУСТО( ИнформацияОКарте ) ) RETURN 0;

ЗначениеКарты = ПОЛЕ_JSON( ИнформацияОКарте, ЧТОПОЛУЧАЕМ, 0);

RETURN ЗначениеКарты;','Функция получает значение данных тэга карты по карте или по номеру телефона клиента
Параметры:
НОМЕРКАРТЫ - номер карты, по которой получаем информацию из системы
НОМЕРТЕЛЕФОНА - номер телефона в формате 7хххууухххх, по которому получаем информацию о карте из системы
ЧТОПОЛУЧАЕМ - наименование тэга, значение которого получаем
ВЫВОДИТЬСООБЩЕНИЕ - признак необходимости вывода сообщения с данными карты',1,'PBONUS.ПолучениеДанных',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_СкриптРасчета','ЛОКАЛЬНАЯ PBONUS_СКРИПТРАСЧЕТА (НОМЕРКАРТЫ, НОМЕРТЕЛЕФОНА, ВЫВОДИТЬСООБЩЕНИЕ)','ОСТАТОК 	= EAPI.PBONUS_КоличествоБонусов( НОМЕРКАРТЫ, НОМЕРТЕЛЕФОНА, ВЫВОДИТЬСООБЩЕНИЕ );

НАЧИСЛЕНО 	= 0;
СПИСАНО 	= 0;
СГОРЕЛО 	= 0;

RETURN true;','Функция выполняет скрипт расчета для бонусного счетчика
Параметры:
НОМЕРКАРТЫ - номер карты, по которой получаем информацию из системы
НОМЕРТЕЛЕФОНА - номер телефона в формате 7хххууухххх, по которому получаем информацию о карте из системы
ВЫВОДИТЬСООБЩЕНИЕ - признак необходимости вывода сообщения с данными карты',1,'PBONUS.ПолучениеДанных',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_DELETEЗАПРОС','ЛОКАЛЬНАЯ PBONUS_DELETEЗАПРОС (АДРЕССЕРВЕРА, РЕСУРС, ЗАГОЛОВКИ)','Ответ = "";
IF ( ПУСТО( ЗАГОЛОВКИ ) )
{
	Заголовки[ 0 ]	= "Content-Type: application/json";
	Заголовки[ 1 ]	= "Authorization: " + ALLTRIM( Токен );	
}

try
{
	ТекстОшибки			= "Сервер " + АдресСервера + CHR( 13 ) + "вернул сообщение об ошибке: " + CHR( 13 );
	Соединение 			= HTTPCONNECT( АдресСервера, "", true, EAPI.ИМЯФАЙЛАЖУРНАЛА( "", "PBONUS_api_log", true ) );
	Ответ				= ПЕРЕКОДИРОВАТЬ( HTTPDELETE( Соединение, Ресурс, "Заголовки" ), "UTF-8", "ANSI" );	
	IF ( !EAPI.PBONUS_ПРОВЕРКАНАОШИБКИ( @Ответ ) ) THROW ( Ответ );
}
catch ( ТекстСообщения )
{
	HTTPCLOSE( Соединение );
	IF (!ПУСТО( ТекстСообщения ))
		СООБЩЕНИЕ( ТекстСообщения, "PBONUS" );
	RETURN false;
}
HTTPCLOSE( Соединение );
RETURN Ответ;','Отправка запроса GET в LOCARDS
Параметры:
АдресСервера - адрес LOCARDS
Ресурс - строка, запрашиваемый ресурс
ЗАГОЛОВКИ - заголовки запроса',1,'PBONUS.Сервис',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_GETЗАПРОС','ЛОКАЛЬНАЯ PBONUS_GETЗАПРОС (АДРЕССЕРВЕРА, РЕСУРС, ЗАГОЛОВКИ)','Ответ = "";
IF (ПУСТО(ЗАГОЛОВКИ))
	Заголовки[0] = "Content-Type: application/json; charset=utf-8";	

try
{
	ТекстОшибки			= "Сервер " + АдресСервера + CHR( 13 ) + "вернул сообщение об ошибке: " + CHR( 13 );
	Соединение 			= HTTPCONNECT( АдресСервера, "", true, EAPI.ИМЯФАЙЛАЖУРНАЛА( "", "PBONUS_api_log", true ) );
	Ответ				= ПЕРЕКОДИРОВАТЬ( HTTPGET( Соединение, Ресурс, "Заголовки" ), "UTF-8", "ANSI" );
	РезультатПроверки	= EAPI.PBONUS_ПРОВЕРКАНАОШИБКИ( @Ответ );
	
	//для варианта, когда определенный документ не найден в ТСД, получаем ответ "-1"
	IF ( TYPE(РезультатПроверки) <> "L" AND РезультатПроверки == -1 )
	{
		HTTPCLOSE( Соединение );
		RETURN РезультатПроверки;
	}
	ELSE IF ( !РезультатПроверки ) THROW ( Ответ );
}
catch ( ТекстСообщения )
{
	HTTPCLOSE( Соединение );
	IF (!ПУСТО( ТекстСообщения ))
		СООБЩЕНИЕ( ТекстСообщения, "PBONUS" );
	RETURN false;
}
HTTPCLOSE( Соединение );
RETURN Ответ;','Отправка запроса GET в LOCARDS
Параметры:
АдресСервера - адрес LOCARDS
Ресурс - строка, запрашиваемый ресурс
ЗАГОЛОВКИ - заголовки запроса',1,'PBONUS.Сервис',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_POSTЗАПРОС','ЛОКАЛЬНАЯ PBONUS_POSTЗАПРОС (АДРЕССЕРВЕРА, РЕСУРС, ТЕЛОЗАПРОСА, ЗАГОЛОВКИ)','Ответ 					= "";
IF ( ПУСТО( ЗАГОЛОВКИ ) )
	Заголовки[ 0 ] 		= "Content-Type: application/json; charset=utf-8";	

try
{
	ТекстОшибки			= "Сервер " + АдресСервера + CHR( 13 ) + "вернул сообщение об ошибке: " + CHR( 13 );
	Соединение 			= HTTPCONNECT( АдресСервера, "", true, EAPI.ИМЯФАЙЛАЖУРНАЛА( "", "PBONUS_api_log", true ) );
	Ответ				= ПЕРЕКОДИРОВАТЬ( HTTPPOST( Соединение, Ресурс, ТелоЗапроса, "Заголовки" ), "UTF-8", "ANSI" );
	//сообщение( ответ );
	IF ( !EAPI.PBONUS_ПРОВЕРКАНАОШИБКИ( @Ответ ) ) THROW ( Ответ );
}
catch ( ТекстСообщения )
{
	HTTPCLOSE( Соединение );
	IF (!ПУСТО(ТекстСообщения))
		СООБЩЕНИЕ( ТекстСообщения, "PBONUS" );
	RETURN "";
}
HTTPCLOSE( Соединение );
RETURN Ответ;','Отправка запроса POST в LOCARDS
Параметры:
АдресСервера - адрес LOCARDS
Ресурс - строка, запрашиваемый ресурс
ТЕЛОЗАПРОСА - строка, которая будет передана серверу в качестве тела запроса
ЗАГОЛОВКИ - заголовки запроса',1,'PBONUS.Сервис',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_TOKEN','ЛОКАЛЬНАЯ PBONUS_TOKEN (НОМЕРКАРТЫ)','Токен			= "";
IF ( !ПУСТО( НОМЕРКАРТЫ ) ) 
{
	// Определим код бонусного счетчика, привязанного к карте
	КОДСЧЕТЧИКАБОНУСОВ = ЗАПРОС( "SELECT bonus FROM sprmcard WHERE cardn = ''" + НОМЕРКАРТЫ + "''" );
	// Если не привязан счетчик к карте, то далее не будем ничего определять и вернем токен из константы _PBTOKEN
	IF ( !ПУСТО( КОДСЧЕТЧИКАБОНУСОВ ) ) 
	{
		// Выберем данные по счетчику с типом бонуса PBONUS и не пустым токеном в доп параметрах
		Токен	= ЗАПРОС( "SELECT dbo.fn_getchar_ex( ''SPR'', ''SA7'', ''PBTOKEN'', code, '''', '''', '''' ) AS token FROM sprbonus WHERE code = ''" + КОДСЧЕТЧИКАБОНУСОВ + "''" );
	}
}
// Если не определили токен, то вернем токен из константы _PBTOKEN
RETURN ЕСЛИ( ПУСТО( Токен ), ПЕРЕМЕННАЯ( "_PBTOKEN", "" ), Токен );
','Получение токена для работы с системой LOCARDS по API',1,'PBONUS.Сервис',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_ВывестиСообщениеОКарте','ЛОКАЛЬНАЯ PBONUS_ВЫВЕСТИСООБЩЕНИЕОКАРТЕ (ИНФОРМАЦИЯОКАРТЕ)','IF ( ПУСТО( ИнформацияОКарте ) ) RETURN "";

Фамилия 			= eapi.jsonnull( ПОЛЕ_JSON( ИнформацияОКарте, "surname", "" ) );
Имя 				= eapi.jsonnull( ПОЛЕ_JSON( ИнформацияОКарте, "name", "" ) );
Отчество 			= eapi.jsonnull( ПОЛЕ_JSON( ИнформацияОКарте, "middle_name", "" ) );
ДРКлиента 			= eapi.jsonnull( ПОЛЕ_JSON( ИнформацияОКарте, "birth_date", "" ) );
БалансКарты			= STR( ПОЛЕ_JSON( ИнформацияОКарте, "balance", 0 ) , 10, 2 );
КоличествоБонусов 	= STR( ПОЛЕ_JSON( ИнформацияОКарте, "balance_bonus_accumulated", 0 ) , 10, 2 );
АктивацияБонусов	= eapi.jsonnull( ПОЛЕ_JSON( ИнформацияОКарте, "bonus_next_activation_text", 0 ) );
НазваниеГруппы		= eapi.jsonnull( ПОЛЕ_JSON( ИнформацияОКарте, "group_name", "" ) );

СимвПС 				= CHR(13) + CHR(10);
ТекстСообщения 		= "";
ТекстСообщения 		+= "Группа:            " + ALLTRIM( НазваниеГруппы ) + СимвПС;
ТекстСообщения 		+= "Клиент:            " + Фамилия + " " + Имя + " " + Отчество + СимвПС;
ТекстСообщения 		+= "Дата рождения:     " + DTOC( CTOD( STRTRANC( ДРКлиента,"-","." ), 7), 4, ".") + СимвПС;
ТекстСообщения 		+= "Баланс карты:      " + БалансКарты + СимвПС;
ТекстСообщения 		+= "Накоплено бонусов: " + КоличествоБонусов + СимвПС;
IF ( !ПУСТО( АктивацияБонусов ) && АктивацияБонусов != "null" )
	ТекстСообщения 	+= "Следующая активация бонусов: " + АктивацияБонусов + СимвПС;
СООБЩЕНИЕ( "font:{courier, 14, 0, 0}" + ТекстСообщения, "PBONUS - Данные карты" );

ВЫВОДИТЬСООБЩЕНИЕ	= false;
RETURN "";','Функция выводит сообщение с данными карты на экран.
Параметры:
ИнформацияОКарте - JSON объект с данными карты',1,'PBONUS.Сервис',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_ПРОВЕРКАНАОШИБКИ','ЛОКАЛЬНАЯ PBONUS_ПРОВЕРКАНАОШИБКИ (ОТВЕТ)','Результат		= true;

IF ( AT( Ответ, "error" ) > 0 ) 
{
	ОтветУспех 		= ПОЛЕ_JSON( Ответ, "success", false );
	IF ( ОтветУспех == false OR ОтветУспех == "false" )
	{
		ТекстОшибки = ПОЛЕ_JSON( Ответ, "error_description", "" );
		Ответ		= "Ошибка: " + CHR( 13 ) + CHR( 10 ) + ТекстОшибки;
		Результат	= false;
	}
}

RETURN Результат;','Проверка ответа от сервера на наличие ошибок
Параметры:
ОТВЕТ - ответ от сервера, который проверяем',1,'PBONUS.Сервис',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'ИМЯФАЙЛАЖУРНАЛА','ЛОКАЛЬНАЯ ИМЯФАЙЛАЖУРНАЛА (ПОЛНЫЙПУТЬКФАЙЛУ, ИМЯФАЙЛА, БЕЗОБОРУДОВАНИЯ)','//Логирование
//определим расположение файла лога
ПутьКФайлу = "";

IF (ПУСТО(ПОЛНЫЙПУТЬКФАЙЛУ))
{
	ПутьКФайлу = ПОКРУЖЕНИЯ("appdata");
	
	//проверим существование каталога
	//если нет каталога в системе, то определим путь до временного каталога
	IF ( !ФАЙЛ(ПутьКФайлу, 1) )
		ПутьКФайлу = ВРЕМЕННЫЙКАТАЛОГ();
	
	//если не определены системные каталоги, то пишем в общий каталог документов для всех пользователей
	//Такая ситуация может возникнуть при выполнении функции службой Айтида, запущенной от имени системной службы
	IF ( !ФАЙЛ(ПутьКФайлу, 1) )
		ПутьКФайлу = "C:\Users\Public\Documents";
	
	//если не определены все каталоги, то будем логировать на диск D
	IF ( !ФАЙЛ(ПутьКФайлу, 1) )
		ПутьКФайлу = "D:";
	
	//если каталог есть в системе, то проверим наличие вложенного каталога Itida
	IF ( !ФАЙЛ(ПутьКФайлу + "\Itida", 1) )
	{
		//если нет каталога Itida, то создадим его
		IF ( КАТАЛОГСОЗДАТЬ(ПутьКФайлу + "\Itida") )
		{
			//если каталог создался, то меняем полный путь с учетом созданного каталога
			ПутьКФайлу = ПутьКФайлу + "\Itida";
		}
	}
	ELSE
	{
		ПутьКФайлу = ПутьКФайлу + "\Itida";
	}
}
ELSE
{
	ПутьКФайлу = LEFT(ПОЛНЫЙПУТЬКФАЙЛУ, RAT(ПОЛНЫЙПУТЬКФАЙЛУ, "\"));	
}

IF ( ПУСТО( ИМЯФАЙЛА ) )
	ИМЯФАЙЛА = "Itida_eapi_log";

ИмяФайлаЖурнала = ПутьКФайлу + ЕСЛИ(ПУСТО(ПутьКФайлу),"","\") + ИМЯФАЙЛА;
IF ( !БЕЗОБОРУДОВАНИЯ AND !ПУСТО( ПЕРЕМЕННАЯ("КОДОБОРУДОВАНИЯ", "") ) )
	ИмяФайлаЖурнала += "_" + ALLTRIM( ПЕРЕМЕННАЯ("КОДОБОРУДОВАНИЯ", "") );	
ИмяФайлаЖурнала += ".txt";

IF ( !ФАЙЛ( ИмяФайлаЖурнала ) )
{
	ФайлЖурнала				= ФАЙЛСОЗДАТЬ( ИмяФайлаЖурнала );
	IF ( ФайлЖурнала == -1 )
	{
		_КОДОШИБКИ			= "001";
		_ТЕКСТОШИБКИ		= "Не удалось создать файл журнала ''" + ALLTRIM( ИмяФайлаЖурнала );
		_ОШИБКАВЫПОЛНЕНИЯ	= true;
		RETURN "";
	}
	ФАЙЛЗАКРЫТЬ( ФайлЖурнала );
}
RETURN ИмяФайлаЖурнала;','Функция определяет расположение файла журнала обмена с сервером и создает его в в этом расположении.
В качестве параметра может быть передано имя файла обмена (например имя файла выгрузки/загрузки, если обмен происходит из профиля оборудования), тогда файл журнала создастся рядом с указанным файлом обмена.
Параметры:
ПОЛНЫЙПУТЬКФАЙЛУ - (необязательное) полный путь к файлу обмена, рядом с которым будет создан файл журнала
ИМЯФАЙЛА - имя файла журнала
БЕЗОБОРУДОВАНИЯ - признак того, что к имени файла журнала не нужно привязывать код торгового оборудования',1,'Сервис',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'НОРМАЛИЗОВАННЫЙТЕЛЕФОН','НОРМАЛИЗОВАННЫЙТЕЛЕФОН (ТЕЛЕФОН)','RETURN ЗАМЕНИТЬ( ЗАМЕНИТЬ( ЗАМЕНИТЬ( ЗАМЕНИТЬ( ЗАМЕНИТЬ( ТЕЛЕФОН, "(", "" ), ")", "" ), "+", "" ), " ", "" ), "-", "" );','',0,'',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'jsonnull','JSONNULL (СТРОКА)','RETURN ЕСЛИ( строка == "null", "", строка );','',0,'Сервис',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_РасчетПокупки','ЛОКАЛЬНАЯ PBONUS_РАСЧЕТПОКУПКИ (ИДЕНТИФИКАТОРЧЕКА, НОМЕРКАРТЫ, СУММАБАЛЛОВ)','
IF  ( ПУСТО( НОМЕРКАРТЫ ) ) 
{
	//СООБЩЕНИЕ("Не определен номер карты. " + CHR(13) + CHR(10) + "Отравка чека в PBONUS проведена не будет.", "PBONUS - отправка чека");
	RETURN 0;
}

Токен = EAPI.PBONUS_TOKEN( НОМЕРКАРТЫ );
IF ( ПУСТО( Токен ) )
{
	СООБЩЕНИЕ("Не определен токен PBONUS. " + CHR(13) + CHR(10) + "Отравка чека в PBONUS проведена не будет.", "PBONUS - отправка чека");
	RETURN 0;
}

//выберем данные шапки документа
ПРОЧИТАТЬНАСТРОЙКИ( "", "city_id,group_id,register_point,register_point_name, register_channel" );

ОТПРАВИТЬСООБЩЕНИЕ( _ДЕСКРИПТОРОКНА, _СООБЩЕНИЕПОЛУЧИТЬЗНАЧЕНИЕПОЛЯ, "telemail" );
phone					= eapi.НОРМАЛИЗОВАННЫЙТЕЛЕФОН( _ЗНАЧЕНИЕПОЛЯ );
sale_point_id			= ПЕРЕМЕННАЯ( "register_point", "" );
sale_point				= ПЕРЕМЕННАЯ( "register_point_name", "" );
discount				= СКИДКАНАЧЕК;
write_off_bonus			= 0;

ТекстЗапроса			= ''
{
  "phone": "'' + phone + ''",
  "sale_point_id": "'' + sale_point_id + ''",
  "sale_point": "'' + sale_point + ''",
  "promocode": "",
  "external_purchase_id": "",
  "cashier_name":"нет",
  "waiters_names": [ "" ],
  "discount": '' + СТРОКА( discount, 10, 2 ) + '',
  "write_off_bonus": '' + СТРОКА( write_off_bonus ) + '',
  "items": 
  [{
      "name": "Товар",
      "external_item_id": "нет",
      "amount": '' + СТРОКА( СУММАКОПЛАТЕ, 10, 2 ) + '',
      "quantity": '' + СТРОКА( 1, 10, 3 ) + '',
      "discount": '' + СТРОКА( СКИДКАНАЧЕК, 10, 2 ) + '',
      "type": "product",
      "groups": [ ],
      "tags": [ ]
  }]
}
'';

УДАЛИТЬКОНТЕКСТ( "СписокСтрок" );
УДАЛИТЬКОНТЕКСТ( "ДанныеДокумента" );

УспешноеВыполнение	= false;

АдресСервера		= "https://site-v2.apipb.ru";
АдресРесурса		= "/purchase-dry-run";

Заголовки[ 0 ] 		= "Authorization: " + ALLTRIM( Токен );	
Заголовки[ 1 ]		= "Content-Type: application/json; charset=utf-8";	
	
ОТВЕТ 				= EAPI.PBONUS_POSTЗАПРОС( АдресСервера, АдресРесурса, ТекстЗапроса, "Заголовки" );

IF ( !ПУСТО( ОТВЕТ ) AND ОТВЕТ != false )
	УспешноеВыполнение = ПОЛЕ_JSON( ОТВЕТ, "success", false );
	
Результат			= 0.00;
IF ( УспешноеВыполнение == true || УспешноеВыполнение == "true" )
{
	УспешноеВыполнение = true;
	Результат		= ЧИСЛО( ПОЛЕ_JSON( ОТВЕТ, "total_write_on_bonus", 0.00 ) );
}

RETURN Результат;
','Функция осуществляет отправку запроса совершения покупки со списанием или без списания баллов
Параметры:
ИДЕНТИФИКАТОРЧЕКА - идентификатор чека в программе Айтида, по которому будет строиться структура чека для отправки
НОМЕРКАРТЫ - номер карты, по которой производим начисление
СУММАБАЛЛОВ - сумма списываемых баллов',1,'PBONUS.ОтправкаДанных',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'ТЕКСТПАРАМЕТРОВ','ТЕКСТПАРАМЕТРОВ ()','RETURN 
''<?xml version="1.0" encoding="utf-8"?>
<Settings>
		<init_script>/*СООБЩЕНИЕ( "Привет!" );*/</init_script>
		<valid_script>/*СООБЩЕНИЕ( "Пока!" );*/</valid_script>
		<Page Caption="Данные клиента">
				<Parameter Name="phone" Caption="Телефон" Description="Телефон" TypeValue="String" ReadOnly="True" InputMask="+7(000)000-00-00" Required= "True">
						<check_script>
								ДЛИНА( ЗАМЕНИТЬ( ЗАМЕНИТЬ( ЗАМЕНИТЬ( phone, ''''('''', '''''''' ), '''')'''', '''''''' ), ''''-'''', '''''''' ) ) >= 9;
						</check_script>
				</Parameter>
				<Parameter Name="referral_code" Caption="Код пригласившего" Description="Код пригласившего" TypeValue="String" />
				<Parameter Name="card_number" Caption="Номер карты покупателя" Description="Номер карты покупателя" TypeValue="String" Required= "True" Barcoder= "True" />
				<Parameter Name="surname" Caption="Фамилия покупателя" Description="Фамилия покупателя" TypeValue="String" Required= "True" />
				<Parameter Name="name" Caption="Имя покупателя" Description="Имя покупателя" TypeValue="String" />
				<Parameter Name="middle_name" Caption="Отчество покупателя" Description="Отчество покупателя" TypeValue="String" />
				<Parameter Name="birth_date" Caption="Дата рождения" Description="Дата рождения" TypeValue="Date" />
				<Parameter Name="gender" Caption="Пол покупателя" Description="Пол покупателя" TypeValue="String">
						<ChoiceList>
								<Item Value="male">Мужской</Item>
								<Item Value="female">Женский</Item>
						</ChoiceList>
				</Parameter>
				<Parameter Name="email" Caption="Электронная почта покупателя" Description="Электронная почта покупателя" TypeValue="String" />
		</Page>
		<Page Caption="Дети">

				<Parameter Name="child1_birth_date" Caption="Дата рождения первого ребенка" Description="Дата рождения первого ребенка" TypeValue="Date" />
				<Parameter Name="child1_name" Caption="Имя первого ребенка" Description="Имя первого ребенка" TypeValue="String" />
				<Parameter Name="child1_gender" Caption="Пол первого ребенка" Description="Пол первого ребенка" TypeValue="String">
						<ChoiceList>
								<Item Value="male">Мужской</Item>
								<Item Value="female">Женский</Item>
						</ChoiceList>
				</Parameter>
				<Parameter Name="child2_birth_date" Caption="Дата рождения второго ребенка" Description="Дата рождения второго ребенка" TypeValue="Date" />
				<Parameter Name="child2_name" Caption="Имя второго ребенка" Description="Имя второго ребенка" TypeValue="String" />
				<Parameter Name="child2_gender" Caption="Пол второго ребенка" Description="Пол второго ребенка" TypeValue="String">
						<ChoiceList>
								<Item Value="male">Мужской</Item>
								<Item Value="female">Женский</Item>
						</ChoiceList>
				</Parameter>
				<Parameter Name="child3_birth_date" Caption="Дата рождения третьего ребенка" Description="Дата рождения третьего ребенка" TypeValue="Date" />
				<Parameter Name="child3_name" Caption="Имя третьего ребенка" Description="Имя третьего ребенка" TypeValue="String" />
				<Parameter Name="child3_gender" Caption="Пол третьего ребенка" Description="Пол третьего ребенка" TypeValue="String">
						<ChoiceList>
								<Item Value="male">Мужской</Item>
								<Item Value="female">Женский</Item>
						</ChoiceList>
				</Parameter>
				<Parameter Name="child4_birth_date" Caption="Дата рождения четвертого ребенка" Description="Дата рождения четвертого ребенка" TypeValue="Date" />
				<Parameter Name="child4_name" Caption="Имя четвертого ребенка" Description="Имя четвертого ребенка" TypeValue="String" />
				<Parameter Name="child4_gender" Caption="Пол четвертого ребенка" Description="Пол четвертого ребенка" TypeValue="String">
						<ChoiceList>
								<Item Value="male">Мужской</Item>
								<Item Value="female">Женский</Item>
						</ChoiceList>
				</Parameter>
		</Page>
		<Page Caption="Прочая информация">
				<Parameter Name="register_channel" Caption="Канал регистрации" Description="Канал регистрации" TypeValue="String" />
				<Parameter Name="register_point" Caption="Точка регистрации" Description="Канал регистрации" TypeValue="String" Required= "True" >
					<href>
						{ 
							"href":"https://site-v2.apipb.ru/cashbox-list", 
							"headers":
							[
								{"header":"Authorization", "value":"_PBTOKEN"}, 
							   	{"header":"Content-type", "value":"\"application/json\""}
							], "type":"post", "body":"''''{\"cashier_name\": \"Иван Иванов\"}''''", "data":"list", "code":"id", "name":"name" 
						}
					</href>
				</Parameter>
				<Parameter Name="group_id" Caption="Группа покупателя" Description="Группа покупателя" TypeValue="String" Required= "True">
					<href>
						{ 
							"href":"https://site-v2.apipb.ru/buyer-groups", 
							"headers":
							[
								{"header":"Authorization", "value":"_PBTOKEN"}, 
							   	{"header":"Content-type", "value":"\"application/json\""}
							], "type":"post", "body":"''''{\"sale_point_id\":\"'''' + register_point + ''''\"}''''", "data":"list", "code":"id", "name":"name" 
						}
					</href>
				</Parameter>
				<Parameter Name="city_id" Caption="Город покупателя" Description="Город покупателя" TypeValue="String" ValueFilter= "бря;кон;аб" Required= "True">
					<href>
						{ 
							"href":"https://site-v2.apipb.ru/city-list", 
							"headers":
							[
								{"header":"Authorization", "value":"_PBTOKEN"}, 
							   	{"header":"Content-type", "value":"\"application/json\""}
							], "type":"post", "body":"''''{}''''", "data":"result", "code":"id", "name":"name" 
						}
					</href>
				</Parameter>
				<Parameter Name="phone_checked" Caption="Телефон проверен" Description="Телефон проверен" TypeValue="Boolean" />
				<Parameter Name="is_refused_receive_messages" Caption="Разрешить получение рекламы" Description="Разрешить получение рекламы" TypeValue="Boolean" />
				<Parameter Name="is_refused_receive_emails" Caption="Разрешить получение электронных писем" Description="Разрешить получение электронных писем" TypeValue="Boolean" />
				<Parameter Name="is_agreed_receive_electronic_receipt" Caption="Разрешить получение электронных чеков" Description="Разрешить получение электронных чеков" TypeValue="Boolean" />
				<Parameter Name="init_purchase_count" Caption="Количество покупок до регистрации" Description="Количество покупок до регистрации" TypeValue="Number" />
				<Parameter Name="init_payment_amount" Caption="Сумма оплаты до регистрации" Description="Сумма оплаты до регистрации" TypeValue="Number" />
				<Parameter Name="cashier_name" Caption="Имя кассира" Description="Имя кассира" TypeValue="String" />
				<Parameter Name="external_id" Caption="ID покупателя во внешней системе" Description="ID покупателя во внешней системе" TypeValue="String" />
		</Page>
</Settings>'';','',0,'',0)
