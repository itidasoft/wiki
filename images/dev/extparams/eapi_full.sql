DECLARE @libname varchar( 250 ), @code char( 10 );
SELECT @libname= '������� API';
SELECT @code= ISNULL( ( SELECT MIN( code ) FROM sprfunctionslib WHERE name= @libname ), '' );
DELETE FROM sprfunctionslib WHERE name= @libname;
INSERT INTO sprfunctionslib (CODE,NAME,ALIAS) VALUES ( @code, '������� API','eapi');
SELECT @code= code FROM sprfunctionslib WHERE name=@libname;
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'�����������������������','����������������������� (�������, ����������, ��������)','// ���������
// ������� - ��������� ������� �������
// �������� - 1 �������� ������� � ����������, ���� ��� ������
//          - 2 ��������� ��������� ������

IF ( �����( ���������� ) && �����( ������� )  )
	RETURN false;
	
�������			= eapi.����������������������( ������� );
// ���� �� ������ �������, �� �� ������ ����� ���� ������� � ��� �����  ��������
IF ( �����( ������� ) )
{
	�������		= ������( "SELECT telefon FROM sprmclient 
						   WHERE cardn = ''" + STDF( ���������� ) + "'' OR 
								 card IN ( SELECT code FROM sprmcard WHERE cardn = ''" + STDF( ���������� ) + "'' ) OR
								 code IN ( SELECT client FROM sprmcard WHERE cardn = ''" + STDF( ���������� ) + "'' )");
}

// ���� ���������� �������� ��� � ����������, �� ����������� ������ �� ������� ������� 
����������������	= eapi.PBONUS_�������������������������( ����������, ������� );
IF ( �����( ���������������� ) )
{
	IF ( �������� == 1 )
	{
		IF ( ���������( "������� " + ������� + " �� ������ � ���� ������." + CHR( 13 ) + "�������� ������ �������?",  "�������� ������ ��������", 4  ) != 6 )
			RETURN "";
	}
	ELSE IF ( �������� == 2 )
	{
		���������( "������� " + ������� + " �� ������ � ���� ������.", "�������� ������ ��������", 0 );
		RETURN "";
	}
}
ELSE IF ( �������� == 1 )
{
	RETURN ����_JSON( ����������������, "card_number", "" );
}

JSONTOVARS( ���������������� );

���������			= eapi.���������������( );//�������������( "c:\trash\pbparams.txt", "S", -1 );

������������������( "", "city_id,group_id,register_point,register_point_name, register_channel" );

IF ( �����( ����������( "card_number", "" ) ) )
	card_number		= ����������;
IF ( �����( ����������( "phone", "" ) ) )
	phone			= �������;
IF ( �����( card_number ) )
	card_number		= phone;
	
������������������( _��������������, _�������������������������, "����������������", ��������� );
IF ( !_������������������������ ) 
	RETURN "";
	
������������������( "", "city_id,group_id,register_point,register_point_name,register_channel" );

// ��������� / �������� ������ � ����������� �������� ���������� ���� � � PBONUS
phone				= ��������( ��������( ��������( ��������( ��������( phone, "(", "" ), ")", "" ), "+", "" ), " ", "" ), "-", "" );
�������				= phone;
����������			= ������������( card_number );
���������� 			= ������( "SELECT code FROM sprmclient WHERE telefon = ''" + STDF( ������� ) + "''" );
��������			= ������( "SELECT code FROM sprmcard WHERE cardn= ''" + STDF( ���������� ) + "''" );
����������			= STDF( ������������( surname ) + ������������( " " + ������������( name ) + " " + ������������( middle_name ) ) + " " + ������� );
��������������		= ������( "SELECT code FROM sprbonus WHERE bonusalias= ''PBONUS''" );

IF ( �����( �������� ) && !�����( ���������� ) )
{
	IF ( !����������������( "INSERT INTO sprmcard ( code, name, ctext, cardn, card_type, bonus, str_date, end_date, counter, saldo ) 
							VALUES ( '''', ''" + ���������� + "'', ''�������� ����� � " + STDF( card_number ) + "'', ''" + STDF( card_number ) + 
							"'', 1, ''" + �������������� + "'', ''20200101'', ''20991231'', " + STR( init_purchase_count ) + ", " + STR( init_payment_amount ) + " ) ", "��" ) )
	{
		���������( "������ ���������� ����� �������:" + CHR( 13 ) + _ERRORDESCRIPTION, "�������� ������ ��������" );
		RETURN "";
	}
	��������		= ������( "SELECT code FROM sprmcard WHERE identity_column= " + ��.ident );
	���������������( "��" );
}

IF ( �����( ���������� ) )
{
	IF ( !����������������( "INSERT INTO sprmclient ( name, ctext, shortname, telefon, cardn, card, email, sex, birthdate, f_sms, f_adv ) 
							 VALUES ( ''" + ���������� + "'', ''" + ���������� + "'', ''" + ���������� + "'', ''" + STDF( ������� ) + "'', ''" + STDF( card_number ) + "'', ''" + �������� + "'',
									  ''" + STDF( email )+ "'', " + ����( gender == "femail", "1", "0" ) + ", ''" + DTOC( birth_date ) + "'',
									   " + ����( is_refused_receive_messages, "1", "0" ) + ", " + ����( is_refused_receive_emails, "1", "0" ) + " ) ", "��" ) )
	{
		���������( "������ ���������� ����� �������:" + CHR( 13 ) + _ERRORDESCRIPTION, "�������� ������ ��������" );
		RETURN "";
	}
	
	����������		= ������( "SELECT code FROM sprmclient WHERE identity_column= " + ��.ident );
	���������������( "��" );
}

IF ( �����( ���������� ) )
{
	���������( "�� ������� �������� ������ ������� � ���� ������.", "�������� ������ ��������" );
	RETURN "";
}

// ���� ���������� �������, �� ���������� ������ �� ����������
���������[ 0 ] 			= "Authorization: " + ALLTRIM( ����� );	
���������[ 1 ] 			= "Content-Type: application/json; charset=utf-8";	
����������������� 		= false;
����������� 			= "phone referral_code card_number surname name middle_name birth_date gender email child1_birth_date child1_name child1_gender child2_birth_date
						   child2_name child2_gender child3_birth_date child3_name child3_gender child4_birth_date child4_name child4_gender register_channel register_point
						   group_id city_id phone_checked is_refused_receive_messages is_refused_receive_emails is_agreed_receive_electronic_receipt 
						   init_purchase_count init_payment_amount cashier_name " + ����( �����( ���������������� ), " external_id", "" );
						   
external_id				= ����������;
������������ 			= "https://site-v2.apipb.ru";
������������ 			= ����( �����( ���������������� ), "/buyer-register", "/buyer-edit" );
����� 					= EAPI.PBONUS_POST������( ������������, ������������, ������������_VJSON( ����������� ), "���������" );

RETURN ����_JSON( �����, "card_number", "" );
','',0,'',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_����������������','��������� PBONUS_���������������� (����������)','��������� = 0;

IF ( ����������� == "������������" AND _�������� != "�������" AND _�������� != "��������������" )
{
	��������� 		= eapi.PBONUS_�����������������( ������, ����������, ������������ );
}
ELSE IF	( ����������� == "������������" AND ( _�������� == "�������" OR _�������� == "��������������" ) )
	EAPI.PBONUS_���������������( ������, _���������������, ����������, true );
ELSE IF ( ����������� == "����������������" )
{
	��������� 		= eapi.PBONUS_�������������( ������, ����������, ������������ );
}
ELSE IF ( ����������� == "������������" )
	��������� 		= 0;
ELSE IF ( ����������� == "����������" )	
	EAPI.PBONUS_���������������( ������, _���������������, ����������, false );
	
RETURN ���������;','������� ��������� ������ ���������� ������ �� ������� �������
���������:
���������� - ����� �����, �� ������� ���������� ����������',1,'PBONUS.��������������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_�����������������','��������� PBONUS_����������������� (�����������������, ����������, �����������)','IF ( �����( ����������������� ) )
{
	���������("�� ��������� ������������� ����. " + CHR(13) + CHR(10) + "������� ���� � PBONUS ��������� �� �����.", "PBONUS - �������� ����");
	RETURN false;
}

IF  ( �����( ���������� ) ) 
{
	//���������("�� ��������� ����� �����. " + CHR(13) + CHR(10) + "������� ���� � PBONUS ��������� �� �����.", "PBONUS - �������� ����");
	RETURN false;
}

����� = EAPI.PBONUS_TOKEN( ���������� );
IF ( �����( ����� ) )
{
	���������("�� ��������� ����� PBONUS. " + CHR(13) + CHR(10) + "������� ���� � PBONUS ��������� �� �����.", "PBONUS - �������� ����");
	RETURN false;
}

//������� ������ ����� ���������
����������������( "SELECT rid, date, firm, cur, sklad, kskod, client, partner, cardnumber, checktype, 
						  subtotal, bonus, chequediscount, chequediscount_prc, telemail, author, shiftnumber, chequenumber, comment
				   FROM chequelist WHERE identity_column = ''" + ����������������� + "''", "���������������" );
���������������( "���������������" );

������������������( "", "city_id,group_id,register_point,register_point_name, register_channel" );

phone					= eapi.����������������������( ���������������.telemail );
sale_point_id			= ����������( "register_point", "" );
sale_point				= ����������( "register_point_name", "" );
sale_channel			= "��������";
promocode				= "";
external_purchase_id	= ���������������.rid;
cashier_name			= ���������������.author;
discount				= ���������������.chequediscount;
write_off_bonus			= ���������������.bonus;

//  "sale_channel": "'' + sale_channel + ''",

������������			= ''
{
  "phone": "'' + phone + ''",
  "sale_point_id": "'' + sale_point_id + ''",
  "sale_point": "'' + sale_point + ''",
  "promocode": "'' + promocode + ''",
  "external_purchase_id": "'' + external_purchase_id + ''",
  '' + ������_JSON( "cashier_name", cashier_name ) + '',
  "waiters_names": [ "" ],
  "discount": '' + ������( discount, 10, 2 ) + '',
  "write_off_bonus": '' + ������( write_off_bonus ) + '',
  "items": ['';
  
 �������������	= "";
 ����������������( "SELECT * FROM chequespec WHERE ic = " + ����������������� , "�����������" );
 WHILE ( !��������������( "�����������" ) )
 {
	IF ( !�����( ������������� ) )
		�������������	+= '','';
		
	�������������	+= ''{
      '' + ������_JSON( "name", �����������.nnname ) + '',
      "external_item_id": "'' + �����������.nn + ''",
      "amount": '' + ������( �����������.summa_wd, 10, 2 ) + '',
      "quantity": '' + ������( �����������.kolp, 10, 3 ) + '',
      "discount": '' + ������( �����������.summa - �����������.summa_wd, 10, 2 ) + '',
      "type": "product",
      "groups": [ ],
      "tags": [ ]
    }'';
	����������( 1, "�����������" );
}
������������	+= ������������� + ''
  ],
  "purchase_status": "approved" }'';

���������������( "�����������" );
���������������( "���������������" );

������������������	= false;

������������		= "https://site-v2.apipb.ru";
������������		= "/purchase";

���������[ 0 ] 		= "Authorization: " + ALLTRIM( ����� );	
���������[ 1 ]		= "Content-Type: application/json; charset=utf-8";	
	
����� 				= EAPI.PBONUS_POST������( ������������, ������������, ������������, "���������" );

IF ( !�����( ����� ) AND ����� != false )
	������������������ = ����_JSON( �����, "success", false );

���������			= 0;
IF ( ������������������ == true || ������������������ == "true" )
{
	������( "UPDATE chequelist SET external_id = ''" + ����_JSON( �����, "purchase_id", '''' ) + "'' WHERE rid = ''" + external_purchase_id + "''" );
	������������������ 	= true;
	���������			= �����( ����_JSON( �����, "total_write_on_bonus", 0.00 ) );
		
	������ 				= CHR( 13 ) + CHR( 10 );
	�������������� 		= "������ ������� �������� � PBonus." + ������;
	�������������� 		+= "��������� �������: " + STR( ����_JSON( �����, "total_write_on_bonus", 0 ), 10, 2 ) + ������;
	�������������� 		+= "������� �������:   " + STR( ����_JSON( �����, "total_write_off_bonus", 0 ), 10, 2 ) + ������;
	�������������� 		+= "������ �����:      " + STR( ����_JSON( �����, "balance", 0 ), 10, 2 ) + ������;
	���������( "font:{courier, 14, 0, 0}" + ��������������, "PBONUS - ��������� �������." );
}
RETURN ���������;

','������� ������������ �������� ������� ���������� ������� �� ��������� ��� ��� �������� ������
���������:
����������������� - ������������� ���� � ��������� ������, �� �������� ����� ��������� ��������� ���� ��� ��������
���������� - ����� �����, �� ������� ���������� ����������
����������� - ����� ����������� ������',1,'PBONUS.��������������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_���������������','��������� PBONUS_��������������� (�����������������, ����������������������, ����������, ����������)','IF ( �����( ����������������� ) )
{
	���������("�� ��������� ������������� ����. " + CHR(13) + CHR(10) + "������� �������� ������ � PBONUS ��������� �� �����.", "PBONUS - �������� ������ ��������");
	RETURN false;
}

IF ( �����( ���������������������� ) AND ���������� == true )
{
	���������("�� ��������� ������������� ���� ���������. " + CHR(13) + CHR(10) + "������� �������� ������ � PBONUS ��������� �� �����.", "PBONUS - �������� ������ ��������");
	RETURN false;
}

IF ( �����( ���������� ) ) 
{
	//���������("�� ��������� ����� �����. " + CHR(13) + CHR(10) + "������� �������� ������ � PBONUS ��������� �� �����.", "PBONUS - �������� ������ ��������");
	RETURN false;
}

����� 			= EAPI.PBONUS_TOKEN( ���������� );
IF ( �����( ����� ) )
{
	���������("�� ��������� ����� PBONUS. " + CHR(13) + CHR(10) + "������� �������� ������ � PBONUS ��������� �� �����.", "PBONUS - �������� ������ ��������");
	RETURN false;
}

//_������������ = ������("SELECT identity_column FROM chequelist WHERE rid = ''" + ���������������������� + "''");
IF ( ���������� == true )
{
	purchase_id	= ������( "	SELECT external_id, rid FROM chequelist WHERE rid = ''" + ���������������������� + "''", "external_id" );

					
}
ELSE
{
	purchase_id	= ������( "	SELECT external_id, rid FROM chequelist WHERE identity_column = ''" + ����������������� + "''" );
}
external_id		= ������( "", "rid" );

������������	= "{""purchase_id"": """ + purchase_id + """, ""external_purchase_id"": """ + external_id + """ }";


������������������ 	= false;
������������ 		= "https://site-v2.apipb.ru";

������������ 		= "/cancel-purchase";

���������[ 0 ] 		= "Authorization: " + ALLTRIM( ����� );	
���������[ 1 ] 		= "Content-Type: application/json; charset=utf-8";	
	
�����				= EAPI.PBONUS_POST������( ������������, ������������, ������������, "���������" );

IF ( !�����( ����� ) AND �����  != false )
	������������������ = ����_JSON( �����_�������, "success", false);

IF ( ������������������ == false OR ������������������ == "false" )
	���������("�� ������� ������� ������� ������� � ������� PBONUS", "PBONUS - �������� ������ ��������");

RETURN ������������������ == true OR ������������������ == "true";','������� ��������� �������� ������� �� �������� ���� �� ��������������
���������:
����������������� - ������������� ���� � ��������� ������, ������� ������� �� ��������� ����������� ����
���������������������� - ������������� ���� � ��������� ������, �� �������� ���������� �������� ��������
���������� - ����� �����, �� ������� ���������� ����������
���������� - ������� �������� ���� �������� (true) ��� ����� ������� ���� (false)',1,'PBONUS.��������������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_�����������������','��������� PBONUS_����������������� (����������, �������������, �����������������)','���������������� 	= EAPI.PBONUS_�������������������������( ����������, ������������� );
IF ( �����( ���������������� ) ) 
	RETURN 0;

�����������			= VAL( ����_JSON( ����������������, "balance_bonus_accumulated", 0 ) );

IF ( ����������( "�����������������", false ) AND !�����( ���������������� ) )
	EAPI.PBONUS_����������������������( ���������������� );	

RETURN �����������;','������� �������� ���������� ������� �� ����� ��� �� ������ �������� �������
���������:
���������� - ����� �����, �� ������� �������� ���������� �� �������
������������� - ����� �������� � ������� 7����������, �� �������� �������� ���������� � ����� �� �������
����������������� - ������� ������������� ������ ��������� � ������� �����',1,'PBONUS.���������������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_�������������������������','��������� PBONUS_������������������������� (����������, �������������)','IF ( �����( ���������� ) AND �����( ������������� ) )
{
	���������( "�� ��������� �� ����� �����, �� ����� �������� �������. " + CHR(13) + CHR(10) + "���������� �� ����� ��������� �� �����.", "PBONUS - ��������� ������");
	RETURN "";
}

����� 		= EAPI.PBONUS_TOKEN( ���������� );
IF ( �����( ����� ) )
{
	���������("�� ��������� ����� PBONUS. " + CHR( 13 ) + CHR( 10 ) + "���������� �� ����� ��������� �� �����.", "PBONUS - ��������� ������");
	RETURN "";
}

���������������� 		= "";
����������������� 		= false;
������������ 			= "https://site-v2.apipb.ru";
������������			= "/buyer-info";
������������			= "{""identificator"": """ + ����( �����( ���������� ), �������������, ���������� ) + """}";

���������[ 0 ] 			= "Authorization: " + ALLTRIM( ����� );	
���������[ 1 ] 			= "Content-Type: application/json; charset=utf-8";	
	
����� 					= EAPI.PBONUS_POST������( ������������, ������������, ������������, "���������" );

IF ( !�����( ����� ) )
{
	����������������� 		= ����_JSON( �����, "success", false );
	IF ( ����������������� == true || ����������������� == "true" )
	{
		����������������� 	= ����_JSON( �����, "is_registered", false );
		IF ( ����������������� == true || ����������������� == "true" )
			���������������� 	= �����;
	}
}

RETURN ����������������;','������� �������� ���������� � ����� �� ������ ����� ��� �� ������ ��������
���������:
���������� - ����� �����, �� ������� �������� ���������� �� �������
������������� - ����� ��������, �� �������� �������� ���������� � ����� �� �������',1,'PBONUS.���������������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_���������������������','��������� PBONUS_��������������������� (����������, �������������, �����������, �����������������)','���������������� = EAPI.PBONUS_�������������������������( ����������, ������������� );

IF ( �����( ���������������� ) ) RETURN 0;

������������� = ����_JSON( ����������������, �����������, 0);

RETURN �������������;','������� �������� �������� ������ ���� ����� �� ����� ��� �� ������ �������� �������
���������:
���������� - ����� �����, �� ������� �������� ���������� �� �������
������������� - ����� �������� � ������� 7����������, �� �������� �������� ���������� � ����� �� �������
����������� - ������������ ����, �������� �������� ��������
����������������� - ������� ������������� ������ ��������� � ������� �����',1,'PBONUS.���������������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_�������������','��������� PBONUS_������������� (����������, �������������, �����������������)','������� 	= EAPI.PBONUS_�����������������( ����������, �������������, ����������������� );

��������� 	= 0;
������� 	= 0;
������� 	= 0;

RETURN true;','������� ��������� ������ ������� ��� ��������� ��������
���������:
���������� - ����� �����, �� ������� �������� ���������� �� �������
������������� - ����� �������� � ������� 7����������, �� �������� �������� ���������� � ����� �� �������
����������������� - ������� ������������� ������ ��������� � ������� �����',1,'PBONUS.���������������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_DELETE������','��������� PBONUS_DELETE������ (������������, ������, ���������)','����� = "";
IF ( �����( ��������� ) )
{
	���������[ 0 ]	= "Content-Type: application/json";
	���������[ 1 ]	= "Authorization: " + ALLTRIM( ����� );	
}

try
{
	�����������			= "������ " + ������������ + CHR( 13 ) + "������ ��������� �� ������: " + CHR( 13 );
	���������� 			= HTTPCONNECT( ������������, "", true, EAPI.���������������( "", "PBONUS_api_log", true ) );
	�����				= ��������������( HTTPDELETE( ����������, ������, "���������" ), "UTF-8", "ANSI" );	
	IF ( !EAPI.PBONUS_����������������( @����� ) ) THROW ( ����� );
}
catch ( �������������� )
{
	HTTPCLOSE( ���������� );
	IF (!�����( �������������� ))
		���������( ��������������, "PBONUS" );
	RETURN false;
}
HTTPCLOSE( ���������� );
RETURN �����;','�������� ������� GET � LOCARDS
���������:
������������ - ����� LOCARDS
������ - ������, ������������� ������
��������� - ��������� �������',1,'PBONUS.������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_GET������','��������� PBONUS_GET������ (������������, ������, ���������)','����� = "";
IF (�����(���������))
	���������[0] = "Content-Type: application/json; charset=utf-8";	

try
{
	�����������			= "������ " + ������������ + CHR( 13 ) + "������ ��������� �� ������: " + CHR( 13 );
	���������� 			= HTTPCONNECT( ������������, "", true, EAPI.���������������( "", "PBONUS_api_log", true ) );
	�����				= ��������������( HTTPGET( ����������, ������, "���������" ), "UTF-8", "ANSI" );
	�����������������	= EAPI.PBONUS_����������������( @����� );
	
	//��� ��������, ����� ������������ �������� �� ������ � ���, �������� ����� "-1"
	IF ( TYPE(�����������������) <> "L" AND ����������������� == -1 )
	{
		HTTPCLOSE( ���������� );
		RETURN �����������������;
	}
	ELSE IF ( !����������������� ) THROW ( ����� );
}
catch ( �������������� )
{
	HTTPCLOSE( ���������� );
	IF (!�����( �������������� ))
		���������( ��������������, "PBONUS" );
	RETURN false;
}
HTTPCLOSE( ���������� );
RETURN �����;','�������� ������� GET � LOCARDS
���������:
������������ - ����� LOCARDS
������ - ������, ������������� ������
��������� - ��������� �������',1,'PBONUS.������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_POST������','��������� PBONUS_POST������ (������������, ������, �����������, ���������)','����� 					= "";
IF ( �����( ��������� ) )
	���������[ 0 ] 		= "Content-Type: application/json; charset=utf-8";	

try
{
	�����������			= "������ " + ������������ + CHR( 13 ) + "������ ��������� �� ������: " + CHR( 13 );
	���������� 			= HTTPCONNECT( ������������, "", true, EAPI.���������������( "", "PBONUS_api_log", true ) );
	�����				= ��������������( HTTPPOST( ����������, ������, �����������, "���������" ), "UTF-8", "ANSI" );
	//���������( ����� );
	IF ( !EAPI.PBONUS_����������������( @����� ) ) THROW ( ����� );
}
catch ( �������������� )
{
	HTTPCLOSE( ���������� );
	IF (!�����(��������������))
		���������( ��������������, "PBONUS" );
	RETURN "";
}
HTTPCLOSE( ���������� );
RETURN �����;','�������� ������� POST � LOCARDS
���������:
������������ - ����� LOCARDS
������ - ������, ������������� ������
����������� - ������, ������� ����� �������� ������� � �������� ���� �������
��������� - ��������� �������',1,'PBONUS.������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_TOKEN','��������� PBONUS_TOKEN (����������)','�����			= "";
IF ( !�����( ���������� ) ) 
{
	// ��������� ��� ��������� ��������, ������������ � �����
	������������������ = ������( "SELECT bonus FROM sprmcard WHERE cardn = ''" + ���������� + "''" );
	// ���� �� �������� ������� � �����, �� ����� �� ����� ������ ���������� � ������ ����� �� ��������� _PBTOKEN
	IF ( !�����( ������������������ ) ) 
	{
		// ������� ������ �� �������� � ����� ������ PBONUS � �� ������ ������� � ��� ����������
		�����	= ������( "SELECT dbo.fn_getchar_ex( ''SPR'', ''SA7'', ''PBTOKEN'', code, '''', '''', '''' ) AS token FROM sprbonus WHERE code = ''" + ������������������ + "''" );
	}
}
// ���� �� ���������� �����, �� ������ ����� �� ��������� _PBTOKEN
RETURN ����( �����( ����� ), ����������( "_PBTOKEN", "" ), ����� );
','��������� ������ ��� ������ � �������� LOCARDS �� API',1,'PBONUS.������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_����������������������','��������� PBONUS_���������������������� (����������������)','IF ( �����( ���������������� ) ) RETURN "";

������� 			= eapi.jsonnull( ����_JSON( ����������������, "surname", "" ) );
��� 				= eapi.jsonnull( ����_JSON( ����������������, "name", "" ) );
�������� 			= eapi.jsonnull( ����_JSON( ����������������, "middle_name", "" ) );
��������� 			= eapi.jsonnull( ����_JSON( ����������������, "birth_date", "" ) );
�����������			= STR( ����_JSON( ����������������, "balance", 0 ) , 10, 2 );
����������������� 	= STR( ����_JSON( ����������������, "balance_bonus_accumulated", 0 ) , 10, 2 );
����������������	= eapi.jsonnull( ����_JSON( ����������������, "bonus_next_activation_text", 0 ) );
��������������		= eapi.jsonnull( ����_JSON( ����������������, "group_name", "" ) );

������ 				= CHR(13) + CHR(10);
�������������� 		= "";
�������������� 		+= "������:            " + ALLTRIM( �������������� ) + ������;
�������������� 		+= "������:            " + ������� + " " + ��� + " " + �������� + ������;
�������������� 		+= "���� ��������:     " + DTOC( CTOD( STRTRANC( ���������,"-","." ), 7), 4, ".") + ������;
�������������� 		+= "������ �����:      " + ����������� + ������;
�������������� 		+= "��������� �������: " + ����������������� + ������;
IF ( !�����( ���������������� ) && ���������������� != "null" )
	�������������� 	+= "��������� ��������� �������: " + ���������������� + ������;
���������( "font:{courier, 14, 0, 0}" + ��������������, "PBONUS - ������ �����" );

�����������������	= false;
RETURN "";','������� ������� ��������� � ������� ����� �� �����.
���������:
���������������� - JSON ������ � ������� �����',1,'PBONUS.������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_����������������','��������� PBONUS_���������������� (�����)','���������		= true;

IF ( AT( �����, "error" ) > 0 ) 
{
	���������� 		= ����_JSON( �����, "success", false );
	IF ( ���������� == false OR ���������� == "false" )
	{
		����������� = ����_JSON( �����, "error_description", "" );
		�����		= "������: " + CHR( 13 ) + CHR( 10 ) + �����������;
		���������	= false;
	}
}

RETURN ���������;','�������� ������ �� ������� �� ������� ������
���������:
����� - ����� �� �������, ������� ���������',1,'PBONUS.������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'���������������','��������� ��������������� (����������������, ��������, ���������������)','//�����������
//��������� ������������ ����� ����
���������� = "";

IF (�����(����������������))
{
	���������� = ����������("appdata");
	
	//�������� ������������� ��������
	//���� ��� �������� � �������, �� ��������� ���� �� ���������� ��������
	IF ( !����(����������, 1) )
		���������� = ����������������();
	
	//���� �� ���������� ��������� ��������, �� ����� � ����� ������� ���������� ��� ���� �������������
	//����� �������� ����� ���������� ��� ���������� ������� ������� ������, ���������� �� ����� ��������� ������
	IF ( !����(����������, 1) )
		���������� = "C:\Users\Public\Documents";
	
	//���� �� ���������� ��� ��������, �� ����� ���������� �� ���� D
	IF ( !����(����������, 1) )
		���������� = "D:";
	
	//���� ������� ���� � �������, �� �������� ������� ���������� �������� Itida
	IF ( !����(���������� + "\Itida", 1) )
	{
		//���� ��� �������� Itida, �� �������� ���
		IF ( ��������������(���������� + "\Itida") )
		{
			//���� ������� ��������, �� ������ ������ ���� � ������ ���������� ��������
			���������� = ���������� + "\Itida";
		}
	}
	ELSE
	{
		���������� = ���������� + "\Itida";
	}
}
ELSE
{
	���������� = LEFT(����������������, RAT(����������������, "\"));	
}

IF ( �����( �������� ) )
	�������� = "Itida_eapi_log";

��������������� = ���������� + ����(�����(����������),"","\") + ��������;
IF ( !��������������� AND !�����( ����������("���������������", "") ) )
	��������������� += "_" + ALLTRIM( ����������("���������������", "") );	
��������������� += ".txt";

IF ( !����( ��������������� ) )
{
	�����������				= �����������( ��������������� );
	IF ( ����������� == -1 )
	{
		_���������			= "001";
		_�����������		= "�� ������� ������� ���� ������� ''" + ALLTRIM( ��������������� );
		_����������������	= true;
		RETURN "";
	}
	�����������( ����������� );
}
RETURN ���������������;','������� ���������� ������������ ����� ������� ������ � �������� � ������� ��� � � ���� ������������.
� �������� ��������� ����� ���� �������� ��� ����� ������ (�������� ��� ����� ��������/��������, ���� ����� ���������� �� ������� ������������), ����� ���� ������� ��������� ����� � ��������� ������ ������.
���������:
���������������� - (��������������) ������ ���� � ����� ������, ����� � ������� ����� ������ ���� �������
�������� - ��� ����� �������
��������������� - ������� ����, ��� � ����� ����� ������� �� ����� ����������� ��� ��������� ������������',1,'������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'����������������������','���������������������� (�������)','RETURN ��������( ��������( ��������( ��������( ��������( �������, "(", "" ), ")", "" ), "+", "" ), " ", "" ), "-", "" );','',0,'',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'jsonnull','JSONNULL (������)','RETURN ����( ������ == "null", "", ������ );','',0,'������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'PBONUS_�������������','��������� PBONUS_������������� (�����������������, ����������, �����������)','
IF  ( �����( ���������� ) ) 
{
	//���������("�� ��������� ����� �����. " + CHR(13) + CHR(10) + "������� ���� � PBONUS ��������� �� �����.", "PBONUS - �������� ����");
	RETURN 0;
}

����� = EAPI.PBONUS_TOKEN( ���������� );
IF ( �����( ����� ) )
{
	���������("�� ��������� ����� PBONUS. " + CHR(13) + CHR(10) + "������� ���� � PBONUS ��������� �� �����.", "PBONUS - �������� ����");
	RETURN 0;
}

//������� ������ ����� ���������
������������������( "", "city_id,group_id,register_point,register_point_name, register_channel" );

������������������( _��������������, _�����������������������������, "telemail" );
phone					= eapi.����������������������( _������������ );
sale_point_id			= ����������( "register_point", "" );
sale_point				= ����������( "register_point_name", "" );
discount				= �����������;
write_off_bonus			= 0;

������������			= ''
{
  "phone": "'' + phone + ''",
  "sale_point_id": "'' + sale_point_id + ''",
  "sale_point": "'' + sale_point + ''",
  "promocode": "",
  "external_purchase_id": "",
  "cashier_name":"���",
  "waiters_names": [ "" ],
  "discount": '' + ������( discount, 10, 2 ) + '',
  "write_off_bonus": '' + ������( write_off_bonus ) + '',
  "items": 
  [{
      "name": "�����",
      "external_item_id": "���",
      "amount": '' + ������( ������������, 10, 2 ) + '',
      "quantity": '' + ������( 1, 10, 3 ) + '',
      "discount": '' + ������( �����������, 10, 2 ) + '',
      "type": "product",
      "groups": [ ],
      "tags": [ ]
  }]
}
'';

���������������( "�����������" );
���������������( "���������������" );

������������������	= false;

������������		= "https://site-v2.apipb.ru";
������������		= "/purchase-dry-run";

���������[ 0 ] 		= "Authorization: " + ALLTRIM( ����� );	
���������[ 1 ]		= "Content-Type: application/json; charset=utf-8";	
	
����� 				= EAPI.PBONUS_POST������( ������������, ������������, ������������, "���������" );

IF ( !�����( ����� ) AND ����� != false )
	������������������ = ����_JSON( �����, "success", false );
	
���������			= 0.00;
IF ( ������������������ == true || ������������������ == "true" )
{
	������������������ = true;
	���������		= �����( ����_JSON( �����, "total_write_on_bonus", 0.00 ) );
}

RETURN ���������;
','������� ������������ �������� ������� ���������� ������� �� ��������� ��� ��� �������� ������
���������:
����������������� - ������������� ���� � ��������� ������, �� �������� ����� ��������� ��������� ���� ��� ��������
���������� - ����� �����, �� ������� ���������� ����������
����������� - ����� ����������� ������',1,'PBONUS.��������������',0)
INSERT INTO specfunctionslib (CODE,NAME,DESCRIPTION_,TEXT_,NOTE,F_LOCAL,GROUPNAME,FARC) VALUES (@code,'���������������','��������������� ()','RETURN 
''<?xml version="1.0" encoding="utf-8"?>
<Settings>
		<init_script>/*���������( "������!" );*/</init_script>
		<valid_script>/*���������( "����!" );*/</valid_script>
		<Page Caption="������ �������">
				<Parameter Name="phone" Caption="�������" Description="�������" TypeValue="String" ReadOnly="True" InputMask="+7(000)000-00-00" Required= "True">
						<check_script>
								�����( ��������( ��������( ��������( phone, ''''('''', '''''''' ), '''')'''', '''''''' ), ''''-'''', '''''''' ) ) >= 9;
						</check_script>
				</Parameter>
				<Parameter Name="referral_code" Caption="��� �������������" Description="��� �������������" TypeValue="String" />
				<Parameter Name="card_number" Caption="����� ����� ����������" Description="����� ����� ����������" TypeValue="String" Required= "True" Barcoder= "True" />
				<Parameter Name="surname" Caption="������� ����������" Description="������� ����������" TypeValue="String" Required= "True" />
				<Parameter Name="name" Caption="��� ����������" Description="��� ����������" TypeValue="String" />
				<Parameter Name="middle_name" Caption="�������� ����������" Description="�������� ����������" TypeValue="String" />
				<Parameter Name="birth_date" Caption="���� ��������" Description="���� ��������" TypeValue="Date" />
				<Parameter Name="gender" Caption="��� ����������" Description="��� ����������" TypeValue="String">
						<ChoiceList>
								<Item Value="male">�������</Item>
								<Item Value="female">�������</Item>
						</ChoiceList>
				</Parameter>
				<Parameter Name="email" Caption="����������� ����� ����������" Description="����������� ����� ����������" TypeValue="String" />
		</Page>
		<Page Caption="����">

				<Parameter Name="child1_birth_date" Caption="���� �������� ������� �������" Description="���� �������� ������� �������" TypeValue="Date" />
				<Parameter Name="child1_name" Caption="��� ������� �������" Description="��� ������� �������" TypeValue="String" />
				<Parameter Name="child1_gender" Caption="��� ������� �������" Description="��� ������� �������" TypeValue="String">
						<ChoiceList>
								<Item Value="male">�������</Item>
								<Item Value="female">�������</Item>
						</ChoiceList>
				</Parameter>
				<Parameter Name="child2_birth_date" Caption="���� �������� ������� �������" Description="���� �������� ������� �������" TypeValue="Date" />
				<Parameter Name="child2_name" Caption="��� ������� �������" Description="��� ������� �������" TypeValue="String" />
				<Parameter Name="child2_gender" Caption="��� ������� �������" Description="��� ������� �������" TypeValue="String">
						<ChoiceList>
								<Item Value="male">�������</Item>
								<Item Value="female">�������</Item>
						</ChoiceList>
				</Parameter>
				<Parameter Name="child3_birth_date" Caption="���� �������� �������� �������" Description="���� �������� �������� �������" TypeValue="Date" />
				<Parameter Name="child3_name" Caption="��� �������� �������" Description="��� �������� �������" TypeValue="String" />
				<Parameter Name="child3_gender" Caption="��� �������� �������" Description="��� �������� �������" TypeValue="String">
						<ChoiceList>
								<Item Value="male">�������</Item>
								<Item Value="female">�������</Item>
						</ChoiceList>
				</Parameter>
				<Parameter Name="child4_birth_date" Caption="���� �������� ���������� �������" Description="���� �������� ���������� �������" TypeValue="Date" />
				<Parameter Name="child4_name" Caption="��� ���������� �������" Description="��� ���������� �������" TypeValue="String" />
				<Parameter Name="child4_gender" Caption="��� ���������� �������" Description="��� ���������� �������" TypeValue="String">
						<ChoiceList>
								<Item Value="male">�������</Item>
								<Item Value="female">�������</Item>
						</ChoiceList>
				</Parameter>
		</Page>
		<Page Caption="������ ����������">
				<Parameter Name="register_channel" Caption="����� �����������" Description="����� �����������" TypeValue="String" />
				<Parameter Name="register_point" Caption="����� �����������" Description="����� �����������" TypeValue="String" Required= "True" >
					<href>
						{ 
							"href":"https://site-v2.apipb.ru/cashbox-list", 
							"headers":
							[
								{"header":"Authorization", "value":"_PBTOKEN"}, 
							   	{"header":"Content-type", "value":"\"application/json\""}
							], "type":"post", "body":"''''{\"cashier_name\": \"���� ������\"}''''", "data":"list", "code":"id", "name":"name" 
						}
					</href>
				</Parameter>
				<Parameter Name="group_id" Caption="������ ����������" Description="������ ����������" TypeValue="String" Required= "True">
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
				<Parameter Name="city_id" Caption="����� ����������" Description="����� ����������" TypeValue="String" ValueFilter= "���;���;��" Required= "True">
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
				<Parameter Name="phone_checked" Caption="������� ��������" Description="������� ��������" TypeValue="Boolean" />
				<Parameter Name="is_refused_receive_messages" Caption="��������� ��������� �������" Description="��������� ��������� �������" TypeValue="Boolean" />
				<Parameter Name="is_refused_receive_emails" Caption="��������� ��������� ����������� �����" Description="��������� ��������� ����������� �����" TypeValue="Boolean" />
				<Parameter Name="is_agreed_receive_electronic_receipt" Caption="��������� ��������� ����������� �����" Description="��������� ��������� ����������� �����" TypeValue="Boolean" />
				<Parameter Name="init_purchase_count" Caption="���������� ������� �� �����������" Description="���������� ������� �� �����������" TypeValue="Number" />
				<Parameter Name="init_payment_amount" Caption="����� ������ �� �����������" Description="����� ������ �� �����������" TypeValue="Number" />
				<Parameter Name="cashier_name" Caption="��� �������" Description="��� �������" TypeValue="String" />
				<Parameter Name="external_id" Caption="ID ���������� �� ������� �������" Description="ID ���������� �� ������� �������" TypeValue="String" />
		</Page>
</Settings>'';','',0,'',0)
