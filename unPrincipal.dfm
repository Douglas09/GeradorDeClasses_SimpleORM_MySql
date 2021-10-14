object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'ClassGenerator'
  ClientHeight = 650
  ClientWidth = 1152
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1152
    Height = 265
    Align = alTop
    BevelOuter = bvNone
    Color = cl3DDkShadow
    ParentBackground = False
    TabOrder = 0
    object Panel3: TPanel
      Left = 11
      Top = 9
      Width = 1133
      Height = 46
      TabOrder = 0
      object Label9: TLabel
        Left = 1
        Top = 1
        Width = 1131
        Height = 44
        Align = alClient
        Alignment = taCenter
        Caption = 'Gerador de Classes SimpleORM - MySql'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBtnHighlight
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 410
        ExplicitHeight = 25
      end
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 61
      Width = 540
      Height = 196
      Caption = 'Configura'#231#227'o de Conex'#227'o'
      Color = clWhite
      DoubleBuffered = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 1
      object Label2: TLabel
        Left = 39
        Top = 28
        Width = 59
        Height = 16
        Caption = 'DriverID:'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label4: TLabel
        Left = 29
        Top = 60
        Width = 69
        Height = 16
        Caption = 'Username:'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label6: TLabel
        Left = 65
        Top = 92
        Width = 33
        Height = 16
        Caption = 'Port:'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label8: TLabel
        Left = 8
        Top = 124
        Width = 90
        Height = 16
        Caption = 'SchemaName:'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 295
        Top = 28
        Width = 67
        Height = 16
        Caption = 'Database:'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label5: TLabel
        Left = 294
        Top = 60
        Width = 68
        Height = 16
        Caption = 'Password:'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label7: TLabel
        Left = 158
        Top = 92
        Width = 49
        Height = 16
        Caption = 'Server:'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object edtDriverID: TEdit
        Left = 103
        Top = 23
        Width = 186
        Height = 26
        TabOrder = 0
        Text = 'MySQL'
      end
      object edtDatabase: TEdit
        Left = 367
        Top = 23
        Width = 165
        Height = 26
        TabOrder = 1
        Text = 'mercurio'
      end
      object edtUserName: TEdit
        Left = 103
        Top = 55
        Width = 186
        Height = 26
        TabOrder = 2
        Text = 'mercuser'
      end
      object edtPassword: TEdit
        Left = 367
        Top = 55
        Width = 165
        Height = 26
        TabOrder = 3
        Text = '#merc3user21.'
      end
      object edtPort: TEdit
        Left = 103
        Top = 87
        Width = 49
        Height = 26
        TabOrder = 4
        Text = '3306'
      end
      object edtServer: TEdit
        Left = 212
        Top = 87
        Width = 320
        Height = 26
        TabOrder = 5
        Text = 'mercurio.clxtlombt2av.sa-east-1.rds.amazonaws.com'
      end
      object edtSchemaName: TEdit
        Left = 104
        Top = 119
        Width = 428
        Height = 26
        TabOrder = 6
        Text = 'mercurio'
      end
      object btnConectar: TButton
        Left = 398
        Top = 151
        Width = 134
        Height = 37
        Caption = 'Conectar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        OnClick = btnConectarClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 572
      Top = 61
      Width = 572
      Height = 196
      Caption = 'Gerar'
      Color = clWhite
      DoubleBuffered = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 2
      object Label11: TLabel
        Left = 15
        Top = 33
        Width = 121
        Height = 16
        Caption = 'Caminho Arquivos:'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object btn2: TButton
        Left = 426
        Top = 151
        Width = 138
        Height = 36
        Caption = 'Gerar Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btn2Click
      end
      object edtPath: TEdit
        Left = 141
        Top = 28
        Width = 423
        Height = 26
        TabOrder = 1
        Text = 'c:\Classes'
      end
      object cheSeparaPasta: TCheckBox
        Left = 141
        Top = 60
        Width = 348
        Height = 17
        Caption = 'Separar arquivos por pasta (Nome Tabela)'
        TabOrder = 2
      end
      object cheEntidade: TCheckBox
        Left = 141
        Top = 83
        Width = 84
        Height = 17
        Caption = 'Entidades'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object cheAutoInc: TCheckBox
        Left = 285
        Top = 83
        Width = 120
        Height = 17
        Caption = 'Gerar AutoInc'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object btn1: TButton
        Left = 282
        Top = 151
        Width = 138
        Height = 36
        Caption = 'Gerar Selecionado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = btn1Click
      end
      object cheVideo: TCheckBox
        Left = 137
        Top = 106
        Width = 195
        Height = 17
        AllowGrayed = True
        Caption = 'Gerar apenas em video'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 6
        Visible = False
      end
    end
  end
  object Panel2: TPanel
    Left = 320
    Top = 265
    Width = 15
    Height = 385
    Align = alLeft
    BevelOuter = bvNone
    Color = cl3DDkShadow
    ParentBackground = False
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 265
    Width = 320
    Height = 385
    Align = alLeft
    DataSource = dsLista_Tabelas
    PopupMenu = PopupMenu1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnColEnter = DBGrid1ColEnter
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'OK'
        Title.Alignment = taCenter
        Width = 33
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TABELA'
        Title.Alignment = taCenter
        Width = 247
        Visible = True
      end>
  end
  object MemVideo: TMemo
    Left = 335
    Top = 265
    Width = 817
    Height = 385
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object FDConexao: TFDConnection
    ConnectionName = 'postgres'
    Params.Strings = (
      'Database=mercurio'
      'User_Name=mercuser'
      'Password=#merc3user21.'
      'Server=mercurio.clxtlombt2av.sa-east-1.rds.amazonaws.com'
      'DriverID=MySQL')
    FetchOptions.AssignedValues = [evMode]
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateMode]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    LoginPrompt = False
    Left = 706
    Top = 392
  end
  object dsLista_Tabelas: TDataSource
    DataSet = qryLista_Tabelas
    Left = 1032
    Top = 440
  end
  object qryLista_Tabelas: TFDQuery
    CachedUpdates = True
    Connection = FDConexao
    FetchOptions.AssignedValues = [evRecsMax, evDetailCascade, evDetailServerCascade]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName, uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.KeyFields = 'TABELA'
    SQL.Strings = (
      'SELECT'
      ' '#39'1'#39' as "OK",'
      'TABLE_NAME AS TABELA,'
      'TABLE_TYPE'
      'FROM'
      '   INFORMATION_SCHEMA.TABLES   '
      'WHERE table_schema = '#39'mercurio'#39
      'ORDER BY'
      '   TABELA ASC')
    Left = 982
    Top = 389
    object qryLista_TabelasOK: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'OK'
      Origin = 'OK'
      ProviderFlags = []
      ReadOnly = True
      Size = 1
    end
    object qryLista_TabelasTABELA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TABELA'
      Origin = '`TABLE_NAME`'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 64
    end
    object qryLista_TabelasTABLE_TYPE: TStringField
      FieldName = 'TABLE_TYPE'
      Origin = 'TABLE_TYPE'
      Required = True
      FixedChar = True
      Size = 11
    end
  end
  object dsCFG_Geral: TDataSource
    Left = 1067
    Top = 712
  end
  object FDMIQ: TFDMetaInfoQuery
    Connection = FDConexao
    MetaInfoKind = mkTableFields
    CatalogName = 'mercurio'
    ObjectName = 'CAD_USUARIO'
    Left = 880
    Top = 336
    object FDMIQRECNO: TIntegerField
      FieldName = 'RECNO'
      ReadOnly = True
    end
    object FDMIQCATALOG_NAME: TWideStringField
      FieldName = 'CATALOG_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMIQSCHEMA_NAME: TWideStringField
      FieldName = 'SCHEMA_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMIQTABLE_NAME: TWideStringField
      FieldName = 'TABLE_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMIQCOLUMN_NAME: TWideStringField
      FieldName = 'COLUMN_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMIQCOLUMN_POSITION: TIntegerField
      FieldName = 'COLUMN_POSITION'
      ReadOnly = True
    end
    object FDMIQCOLUMN_DATATYPE: TIntegerField
      FieldName = 'COLUMN_DATATYPE'
      ReadOnly = True
    end
    object FDMIQCOLUMN_TYPENAME: TWideStringField
      FieldName = 'COLUMN_TYPENAME'
      ReadOnly = True
      Size = 128
    end
    object FDMIQCOLUMN_ATTRIBUTES: TLongWordField
      FieldName = 'COLUMN_ATTRIBUTES'
      ReadOnly = True
    end
    object FDMIQCOLUMN_PRECISION: TIntegerField
      FieldName = 'COLUMN_PRECISION'
      ReadOnly = True
    end
    object FDMIQCOLUMN_SCALE: TIntegerField
      FieldName = 'COLUMN_SCALE'
      ReadOnly = True
    end
    object FDMIQCOLUMN_LENGTH: TIntegerField
      FieldName = 'COLUMN_LENGTH'
      ReadOnly = True
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 1032
    Top = 504
    object SelecionarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = SelecionarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = DesmarcarTodos1Click
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 720
    Top = 472
  end
  object qryComentario: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      ' SELECT a.`COLUMN_COMMENT`, a.`COLUMN_NAME`  '
      ' FROM `information_schema`.`COLUMNS` a'
      ' WHERE a.`TABLE_SCHEMA` = :banco AND a.`TABLE_NAME` = :tabela '
      ' AND a.`COLUMN_NAME` = :coluna')
    Left = 808
    Top = 416
    ParamData = <
      item
        Name = 'BANCO'
        ParamType = ptInput
      end
      item
        Name = 'TABELA'
        ParamType = ptInput
      end
      item
        Name = 'COLUNA'
        ParamType = ptInput
      end>
    object qryComentarioCOLUMN_COMMENT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COLUMN_COMMENT'
      Origin = 'COLUMN_COMMENT'
      Size = 2048
    end
    object qryComentarioCOLUMN_NAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COLUMN_NAME'
      Origin = 'COLUMN_NAME'
      Size = 64
    end
  end
end
