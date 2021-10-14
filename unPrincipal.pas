unit unPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, IniFiles,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,  FireDAC.Comp.Client, FireDAC.DApt, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TfrmPrincipal = class(TForm)
    FDConexao: TFDConnection;
    Panel1: TPanel;
    dsLista_Tabelas: TDataSource;
    qryLista_Tabelas: TFDQuery;
    Panel2: TPanel;
    dsCFG_Geral: TDataSource;
    Panel3: TPanel;
    Label9: TLabel;
    FDMIQ: TFDMetaInfoQuery;
    FDMIQRECNO: TIntegerField;
    FDMIQCATALOG_NAME: TWideStringField;
    FDMIQSCHEMA_NAME: TWideStringField;
    FDMIQTABLE_NAME: TWideStringField;
    FDMIQCOLUMN_NAME: TWideStringField;
    FDMIQCOLUMN_POSITION: TIntegerField;
    FDMIQCOLUMN_DATATYPE: TIntegerField;
    FDMIQCOLUMN_TYPENAME: TWideStringField;
    FDMIQCOLUMN_ATTRIBUTES: TLongWordField;
    FDMIQCOLUMN_PRECISION: TIntegerField;
    FDMIQCOLUMN_SCALE: TIntegerField;
    FDMIQCOLUMN_LENGTH: TIntegerField;
    PopupMenu1: TPopupMenu;
    SelecionarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    DBGrid1: TDBGrid;
    MemVideo: TMemo;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    edtDriverID: TEdit;
    edtDatabase: TEdit;
    edtUserName: TEdit;
    edtPassword: TEdit;
    edtPort: TEdit;
    edtServer: TEdit;
    edtSchemaName: TEdit;
    btnConectar: TButton;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    btn2: TButton;
    edtPath: TEdit;
    cheSeparaPasta: TCheckBox;
    cheEntidade: TCheckBox;
    cheAutoInc: TCheckBox;
    btn1: TButton;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    qryLista_TabelasOK: TStringField;
    qryLista_TabelasTABELA: TStringField;
    cheVideo: TCheckBox;
    qryLista_TabelasTABLE_TYPE: TStringField;
    qryComentario: TFDQuery;
    qryComentarioCOLUMN_COMMENT: TStringField;
    qryComentarioCOLUMN_NAME: TStringField;
    procedure btnConectarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure SelecionarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure qryLista_TabelasOKGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    procedure Conecta_Bancos;
    procedure Gera_Entidade(aTable: string);
    procedure Verifica_AutoInc(autoIncField : string);
  public

  end;

var
  frmPrincipal: TfrmPrincipal;
  FClasse: TStringList;
  FPrivate: TStringList;
  FBody: TStringList;
  FInterface: TStringList;
  FProperty: TStringList;
  FPropertyInterface: TStringList;
  FProcedureLimpar: TStringList;
  FPK: TStringList;
  FTableName: String;
  FUnitName: String;
  FTipoCampo: String;
  FProjeto: String;


  VAutoInc : Boolean;


  vEntidade : TMemo;

  vController : TMemo;
  vReactList : TMemo;
  vReactForm : TMemo;
  SeqField : string;
implementation

{$R *.dfm}

procedure TfrmPrincipal.Gera_Entidade(aTable : string);
var
  FProperty, FPropertyInterface, FProcedureLimpar, FProcedureToJson,
  FPK, FFunctionJsonToClass: TStringList;
  FUnitName, FTipoCampo, MPK, Classe: String;
  I: Integer;
begin
  FInterface           := TStringList.Create;
  FBody                := TStringList.Create;
  FPrivate             := TStringList.Create;
  FClasse              := TStringList.Create;
  FProperty            := TStringList.Create;
  FPropertyInterface   := TStringList.Create;
  FProcedureLimpar     := TStringList.Create;
  FProcedureToJson     := TStringList.Create;
  FFunctionJsonToClass := TStringList.Create;
  FPK                  := TStringList.Create;
  FClasse              := TStringList.Create;
  FDConexao.GetKeyFieldNames('',  '', aTable, '', FPK);
  Classe := AnsiUpperCase(Copy(aTable, 1, 1)) + Copy(aTable, 2, Length(aTable));
  FDMIQ.Active       := False;
  FDMIQ.MetaInfoKind := mkTableFields;
  FDMIQ.ObjectName   := aTable;
  FDMIQ.Active       := True;
  while not(FDMIQ.Eof) do
  begin
    if (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'BIGINT') then
    begin
      FTipoCampo := 'Int64';
      FProcedureLimpar.Add('  Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' := 0;');
      FProcedureToJson.Add('  if (pFields.Contains(''*'') or AnsiUpperCase(pFields).Contains('' '+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +' '')) then');
      FProcedureToJson.Add('    result.addPair('+ QuotedStr(ansiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +', IntToStr(Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +'));');
      if (qryLista_TabelasTABLE_TYPE.AsString <> 'VIEW') AND (AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString).contains('empresa_idpk')) then //CÓDIGO DA EMPRESA
        FFunctionJsonToClass.Add('      result.'+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                                 ' := StrToInt64(getEmpresaIdpk);')
      else if (qryLista_TabelasTABLE_TYPE.AsString <> 'VIEW') AND (AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString).contains('filial_idpk')) then //CÓDIGO DA FILIAL
        FFunctionJsonToClass.Add('      result.'+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                                 ' := StrToInt64(getFilialIdpk);')
      else
        FFunctionJsonToClass.Add('      Try result.'+ AnsiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                                 ' := StrToInt64(obj.get('+ QuotedStr(AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +').JsonValue.Value); Except End;');
    end else if (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper.Contains('INT')) then
    begin
      FTipoCampo := 'Integer';
      FProcedureLimpar.Add('  Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' := 0;');
      FProcedureToJson.Add('  if (pFields.Contains(''*'') or AnsiUpperCase(pFields).Contains('' '+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +' '')) then');
      FProcedureToJson.Add('    result.addPair('+ QuotedStr(ansiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +', IntToStr(Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +'));');
      if (qryLista_TabelasTABLE_TYPE.AsString <> 'VIEW') AND (AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString).contains('empresa_idpk')) then //CÓDIGO DA EMPRESA
        FFunctionJsonToClass.Add('      result.'+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                                 ' := StrToInt(getEmpresaIdpk);')
      else if (qryLista_TabelasTABLE_TYPE.AsString <> 'VIEW') AND (AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString).contains('filial_idpk')) then //CÓDIGO DA FILIAL
        FFunctionJsonToClass.Add('      result.'+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                                 ' := StrToInt(getFilialIdpk);')
      else
        FFunctionJsonToClass.Add('      Try result.'+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                                 ' := StrToInt(obj.get('+ QuotedStr(AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +').JsonValue.Value); Except End;');
    end else if ((FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'NUMERIC') or
                 (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'DECIMAL') or
                 (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'FLOAT') or
                 (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'DOUBLE PRECISION') or
                 (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'DOUBLE'))
    then
    begin
      FTipoCampo := 'Currency';
      FProcedureLimpar.Add('  Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' := 0;');
      FProcedureToJson.Add('  if (pFields.Contains(''*'') or AnsiUpperCase(pFields).Contains('' '+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +' '')) then');
      FProcedureToJson.Add('    result.addPair('+ QuotedStr(ansiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +', FloatToStr(Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +'));');
      FFunctionJsonToClass.Add('      Try result.'+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                               ' := StrToFloat(obj.get('+ QuotedStr(AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +').JsonValue.Value); Except End;');
    end else if (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'BLOB SUB_TYPE 1') or
                (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'BLOB SUB_TYPE 2') or
                (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'BLOB SUB_TYPE 0') or
                (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'VARCHAR') or
                (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'JSON') or
                (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'TEXT') or
                (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'CHAR') then
    begin
      FTipoCampo := 'String';
      FProcedureLimpar.Add('  Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' := '''';');
      FProcedureToJson.Add('  if (pFields.Contains(''*'') or AnsiUpperCase(pFields).Contains('' '+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +' '')) then');
      FProcedureToJson.Add('    result.addPair('+ QuotedStr(ansiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +', Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +');');
      FFunctionJsonToClass.Add('      Try result.'+ AnsiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                               ' := obj.get('+ QuotedStr(AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +').JsonValue.Value; Except End;');
    end
    else
    if (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'VARBINARY') then
    begin
      FTipoCampo := 'TMemoField';
      FProcedureLimpar.Add('  Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' := '''';');
      FProcedureToJson.Add('  if (pFields.Contains(''*'') or AnsiUpperCase(pFields).Contains('' '+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +' '')) then');
      FProcedureToJson.Add('    result.addPair('+ QuotedStr(ansiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +', Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +'.Lines.Text);');
      FFunctionJsonToClass.Add('      Try result.'+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                               '.Text := obj.get('+ QuotedStr(AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +').JsonValue.Value; Except End;');
    end
    else
    if (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'DATE') or
       (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'TIME') or
       (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'TIMESTAMP') or
       (FDMIQ.FieldByName('COLUMN_TYPENAME').AsString.Trim.ToUpper = 'DATETIME')
    then
    begin
      FTipoCampo := 'TDateTime';
      FProcedureLimpar.Add('  Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' := 0;');
      FProcedureToJson.Add('  if (pFields.Contains(''*'') or AnsiUpperCase(pFields).Contains('' '+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +' '')) then');
      FProcedureToJson.Add('    result.addPair('+ QuotedStr(ansiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +', DateTimeToStr(Self.' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +'));');
      FFunctionJsonToClass.Add('      Try result.'+ ansiUpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) +
                               ' := StrToDateTime(obj.get('+ QuotedStr(AnsiLowerCase(FDMIQ.FieldByName('COLUMN_NAME').AsString)) +').JsonValue.Value); Except End;');
    end;
    FInterface.Add('    procedure Set' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' (const Value :' + FTipoCampo + ');');
    FInterface.Add('    function Get' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' :' + FTipoCampo + ';');
    for I := 0 to FPK.Count-1 do
    begin
      if FPK[I].Trim.ToUpper = FDMIQ.FieldByName('COLUMN_NAME').AsString.Trim.ToUpper then
      begin
        SeqField := '';
        VAutoInc := False;
        if cheAutoInc.Checked then
           Verifica_AutoInc(FDMIQ.FieldByName('COLUMN_NAME').AsString);
        if VAutoInc = True then
        begin
          SeqField := FDMIQ.FieldByName('COLUMN_NAME').AsString;
          MPK := '    [Campo(' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString.QuotedString) + '), PK, AutoInc]';
        end
        else
          MPK := '    [Campo(' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString.QuotedString) + '), PK]';
        VAutoInc := False;
        Break;
      end
      else
        MPK := '    [Campo(' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString.QuotedString) + ')]';
    end;
    FProperty.Add(MPK);

    //Adicionar comentário nas propriedades das colunas do banco de dados
    qryComentario.Close;
    qryComentario.ParamByName('banco').AsString := edtSchemaName.Text;
    if aTable.Contains('view_') then
      qryComentario.ParamByName('tabela').AsString := Copy(aTable, 6, length(aTable))
    else
      qryComentario.ParamByName('tabela').AsString := aTable;
    qryComentario.ParamByName('coluna').AsString := FDMIQ.FieldByName('COLUMN_NAME').AsString;
    qryComentario.Open;

    if (qryComentarioCOLUMN_COMMENT.AsString <> '') then
    begin
      FProperty.Add('    /// <summary> ' +sLineBreak+
        '    ///  '+ StringReplace(qryComentarioCOLUMN_COMMENT.AsString, #$A, #$A + '    ///  ', [rfReplaceAll]) +sLineBreak+
        '    /// </summary>');
    end;

    FProperty.Add('    property ' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' :' + FTipoCampo + ' read Get' +
      UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' write Set' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ';');
    FPropertyInterface.Add('    property ' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' :' + FTipoCampo + ' read Get' +
      UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' write Set' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ';');
    FBody.Add('procedure T' + Classe + '.Set' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' (const Value :' + FTipoCampo + ');');
    FBody.Add('begin');
    FBody.Add('  F' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' := Value;');
    FBody.Add('end;');
    FBody.Add('');
    FBody.Add('function T' + Classe + '.Get' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' :' + FTipoCampo + ';');
    FBody.Add('begin');
    FBody.Add('  Result := F' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ';');
    FBody.Add('end;');
    FBody.Add('');
    FPrivate.Add('    F' + UpperCase(FDMIQ.FieldByName('COLUMN_NAME').AsString) + ' :' + FTipoCampo + ';');
    FDMIQ.Next;
  end;
  FClasse.Clear;
  if (qryLista_TabelasTABLE_TYPE.AsString = 'VIEW') then
     FClasse.Add('unit View.' + Classe + ';')
  else
     FClasse.Add('unit Table.' + Classe + ';');
  FClasse.Add('');
  FClasse.Add('interface');
  FClasse.Add('');
  FClasse.Add('uses ');
  FClasse.Add('  Controller, System.Json, System.SysUtils, System.Variants, SimpleAttributes;');
  FClasse.Add('');
  FClasse.Add('type');
  FClasse.Add('  [Tabela(''' + AnsiLowerCase(Classe) + ''')]');
  FClasse.Add('  T' + Classe + ' = class');
  FClasse.Add('  private');
  FClasse.Add('    FCOUNT: Integer;');
  FClasse.Add(FPrivate.Text);
  FClasse.Add(FInterface.Text);
  FClasse.Add('    procedure SetCOUNT(const Value: Integer);');
  FClasse.Add('  public');
  FClasse.Add('    constructor Create;');
  FClasse.Add('    destructor Destroy; override;');
  FClasse.Add('    procedure Limpar;');
  FClasse.Add('    function ToJson(pFields : String = ''*'') : TJSonObject;');
  FClasse.Add('    function JsonToClass(obj : TJSonObject) : T'+ Classe +';');
  FClasse.Add(FProperty.Text);
  FClasse.Add('    [Campo(''COUNT''), Ignore]');
  FClasse.Add('    property COUNT : Integer read FCOUNT write SetCOUNT;');
  FClasse.Add('end;');
  FClasse.Add('');
  FClasse.Add('implementation');
  FClasse.Add('');
  FClasse.Add('constructor T' + Classe + '.Create;');
  FClasse.Add('begin');
  FClasse.Add('  Limpar;');
  FClasse.Add('end;');
  FClasse.Add('');
  FClasse.Add('destructor T' + Classe + '.Destroy;');
  FClasse.Add('begin');
  FClasse.Add('');
  FClasse.Add('  inherited;');
  FClasse.Add('end;');
  FClasse.Add('');
  FClasse.Add(FBody.Text);
  FClasse.Add('procedure T' + Classe + '.Limpar;');
  FClasse.Add('begin');
  FClasse.Add(FProcedureLimpar.Text);
  FClasse.Add('end;');
  FClasse.Add('');
  FClasse.Add('procedure T'+Classe+'.SetCOUNT(const Value: Integer);');
  FClasse.Add('begin');
  FClasse.Add('  FCOUNT := Value;');
  FClasse.Add('end;');
  FClasse.Add('function T' + Classe + '.ToJson(pFields : String = ''*'') : TJSonObject;');
  FClasse.Add('begin');
  FClasse.Add('  pFields := '' ''+ StringReplace(pFields, '','', '' '', [rfReplaceAll]);');
  FClasse.Add('  result := TJSonObject.Create;');
  FClasse.Add(FProcedureToJson.Text);
  FClasse.Add('end;');
  FClasse.Add('function T' + Classe + '.JsonToClass(obj : TJSonObject) : T'+ Classe +';');
  FClasse.Add('begin');
  FClasse.Add('  result := T'+ Classe +'.Create;');
  FClasse.Add('  if (assigned(obj)) then');
  FClasse.Add('  begin');
  FClasse.Add('    Try');
  FClasse.Add(FFunctionJsonToClass.Text);
  FClasse.Add('    Except');
  FClasse.Add('      on E : Exception do');
  FClasse.Add('      begin');
  FClasse.Add('        result.Free;');
  FClasse.Add('        raise Exception.Create(E.Message);');
  FClasse.Add('      end;');
  FClasse.Add('    End;');
  FClasse.Add('  end;');
  FClasse.Add('end;');
  FClasse.Add('');
  FClasse.Add('end.');
  VEntidade.Text := FClasse.Text;

  MemVideo.Text := FClasse.Text;

  FDMIQ.Active := False;
end;

procedure TfrmPrincipal.qryLista_TabelasOKGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
 Text := EmptyStr;
end;

procedure TfrmPrincipal.SelecionarTodos1Click(Sender: TObject);
begin
  qryLista_Tabelas.First;
  while not qryLista_Tabelas.Eof do
    begin
      qryLista_tabelas.Edit;
      qryLista_TabelasOK.asString := '1';
      qryLista_tabelas.Post;

      qryLista_tabelas.Next;
    end;
end;

procedure TfrmPrincipal.Verifica_AutoInc(autoIncField : string);
var
  FClasse: TStringList;
  i: integer;
  sequence : string;
begin

  vAutoInc :=(Copy(autoIncField, 5, length(autoIncField)) = 'idpk');


//  sequence := qryLista_TabelasTABELA.AsString + '_' + autoIncField + '_seq';
//
//  FClasse := TStringList.Create;
//  FDConexao.GetGeneratorNames('', '', sequence, FClasse);
//
//  if FClasse.count = 1 then
//    begin
//      VAutoInc := True;
//    end;
end;

procedure TfrmPrincipal.btnConectarClick(Sender: TObject);
begin
  if btnConectar.Caption = 'Conectar' then
    begin
      FDConexao.Connected := False;
      Conecta_Bancos;
      btnConectar.Caption := 'Desconectar';
      btn1.Enabled := True;
      btn2.Enabled := True;
      qryLista_Tabelas.Open();
    end
  else
    begin
      FDConexao.Connected := False;
      btnConectar.Caption := 'Conectar';
      btn1.Enabled := False;
      btn2.Enabled := False;
    end;
end;

procedure TfrmPrincipal.Conecta_Bancos;
begin
  // Parametros BD
  if (edtDriverID.Text = '') or (edtDriverID.Text = '') or (edtDriverID.Text = '') or (edtDriverID.Text = '') or (edtDriverID.Text = '') or (edtDriverID.Text = '') then
    begin
      ShowMessage('Preencha os campos referente ao servidor');
    end
  else
    begin
      FDConexao.Params.DriverID := edtDriverID.Text;
      FDConexao.Params.Database := edtDatabase.Text;
      FDConexao.Params.UserName := edtUserName.Text;
      FDConexao.Params.Password := edtPassword.Text;
      FDConexao.Params.Values['Port'] := edtPort.Text;
      FDConexao.Params.Values['Server'] := edtServer.Text;

      try
        // Tenta conectar no Banco de Dados
        FDConexao.Connected := True;
      except
        // Se a conexão falhar mostra mensagem
        on e: Exception do
        begin
          ShowMessage(e.Message);
        end;
      end;
    end;
end;

procedure TfrmPrincipal.DBGrid1CellClick(Column: TColumn);
begin
  if(UpperCase(Column.FieldName) = 'OK') then
  begin
    qryLista_Tabelas.Edit;
    if(qryLista_Tabelas.FieldByName('OK').AsInteger = 1) then
    begin
      qryLista_Tabelas.FieldByName('OK').AsInteger := 0;
    end
    else
    begin
      qryLista_Tabelas.FieldByName('OK').AsInteger := 1;
    end;
   qryLista_Tabelas.Post;
  end;
end;

procedure TfrmPrincipal.DBGrid1ColEnter(Sender: TObject);
begin
  if UpperCase(TDBGrid(Sender).SelectedField.FieldName) = 'OK' then
    TDBGrid(Sender).Options := TDBGrid(Sender).Options - [dgEditing]
  else
    TDBGrid(Sender).Options := TDBGrid(Sender).Options + [dgEditing];
end;

procedure TfrmPrincipal.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
 var
  Check: Integer;
  R: TRect;
begin
  if ((Sender as TDBGrid).DataSource.Dataset.IsEmpty) then
    Exit;

  if(UpperCase(Column.FieldName) = 'OK') then
  begin
    TDBGrid(Sender).Canvas.FillRect(Rect);
    if (TDBGrid(Sender).DataSource.DataSet.FieldByName('OK').AsInteger = 1) then
      Check := DFCS_CHECKED
    else
      Check := 0;
    R := Rect;
    InflateRect(R, -2, -2);
    DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON,
      DFCS_BUTTONCHECK or Check);
  end;
end;

procedure TfrmPrincipal.DesmarcarTodos1Click(Sender: TObject);
begin
  qryLista_Tabelas.First;
  while not qryLista_Tabelas.Eof do
    begin
      qryLista_tabelas.Edit;
      qryLista_TabelasOK.asString := '0';
      qryLista_tabelas.Post;

      qryLista_tabelas.Next;
    end;
end;

procedure TfrmPrincipal.btn2Click(Sender: TObject);
var
  Tabelas, Fields: TStringList;
begin
  qryLista_Tabelas.First;
  while not qryLista_Tabelas.Eof do
    begin
      if qryLista_TabelasOK.asString = '1' then
        begin
          //Gera Entidade
          if (cheEntidade.Checked) then
             Gera_Entidade(qryLista_TabelasTABELA.AsString);
          
          //Separado Por Pasta
          if cheSeparaPasta.Checked then
          begin
            if cheVideo.Checked = false then
            begin
              //Entidade
              if cheEntidade.Checked then
              begin
                if not DirectoryExists(edtPath.Text) then
                  CreateDir(edtPath.Text);
                if not DirectoryExists(edtPath.Text) then
                  CreateDir(edtPath.Text);
                if not DirectoryExists(edtPath.Text + qryLista_TabelasTABELA.asString) then
                  CreateDir(edtPath.Text + qryLista_TabelasTABELA.asString);

                if (qryLista_TabelasTABLE_TYPE.AsString = 'VIEW') then                   
                  VEntidade.Lines.SaveToFile(edtPath.Text + qryLista_TabelasTABELA.asString + '\View.' + UpperCase(qryLista_TabelasTABELA.asString) + '.pas')
                else
                  VEntidade.Lines.SaveToFile(edtPath.Text + qryLista_TabelasTABELA.asString + '\Table.' + UpperCase(qryLista_TabelasTABELA.asString) + '.pas');
              end;
            end;
          end
          else
          //Todos na mesma pasta
          begin
            if cheVideo.Checked = false then
            begin
              //Entidade
              if cheEntidade.Checked then
              begin
                if not DirectoryExists(edtPath.Text) then
                  CreateDir(edtPath.Text);
                if not DirectoryExists(edtPath.Text) then
                  CreateDir(edtPath.Text);

                if (qryLista_TabelasTABLE_TYPE.AsString = 'VIEW') then
                  VEntidade.Lines.SaveToFile(edtPath.Text + 'View.' + UpperCase(qryLista_TabelasTABELA.asString) + '.pas')
                else
                  VEntidade.Lines.SaveToFile(edtPath.Text + 'Table.' + UpperCase(qryLista_TabelasTABELA.asString) + '.pas');
              end;
            end;
          end;
        end;
      qryLista_Tabelas.Next;
    end;

  ShowMessage('Arquivos gerados com sucesso');
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  vEntidade := TMemo.Create(Self);
  vController := TMemo.Create(Self);
  vReactList := TMemo.Create(Self);
  VReactForm := TMemo.Create(Self);

  edtPath.Text := 'C:\MercurioWEB\back\projetos\MercurioServidor\fontes\Database\Model\';
//  edtPath.Text := ExtractFilePath( Application.ExeName ) +'Entidades';
  if not (directoryExists(edtPath.Text)) then
     ForceDirectories(edtPath.Text);
end;

procedure TfrmPrincipal.btn1Click(Sender: TObject);
var
  Tabelas, Fields: TStringList;
begin
  //Gera Entidade
  if cheEntidade.Checked then
     Gera_Entidade(qryLista_TabelasTABELA.AsString);

  //Separado Por Pasta
  if cheSeparaPasta.Checked then
  begin
    if cheVideo.Checked = false then
    begin
      //Entidade
      if cheEntidade.Checked then
      begin
        if not DirectoryExists(edtPath.Text) then
          CreateDir(edtPath.Text);
        if not DirectoryExists(edtPath.Text) then
          CreateDir(edtPath.Text);
        if not DirectoryExists(edtPath.Text + qryLista_TabelasTABELA.asString) then
          CreateDir(edtPath.Text + qryLista_TabelasTABELA.asString);

        if (qryLista_TabelasTABLE_TYPE.AsString = 'VIEW') then
          VEntidade.Lines.SaveToFile(edtPath.Text + qryLista_TabelasTABELA.asString + '\View.' + UpperCase(qryLista_TabelasTABELA.asString) + '.pas')
        else
          VEntidade.Lines.SaveToFile(edtPath.Text + qryLista_TabelasTABELA.asString + '\Table.' + UpperCase(qryLista_TabelasTABELA.asString) + '.pas');
      end;
    end;
  end
  else
  //Todos na mesma pasta
  begin
    if cheVideo.Checked = false then
    begin
      //Entidade
      if cheEntidade.Checked then
      begin
        if not DirectoryExists(edtPath.Text) then
          CreateDir(edtPath.Text);
        if not DirectoryExists(edtPath.Text) then
          CreateDir(edtPath.Text);

        if (qryLista_TabelasTABLE_TYPE.AsString = 'VIEW') then
          VEntidade.Lines.SaveToFile(edtPath.Text + 'View.' + UpperCase(qryLista_TabelasTABELA.asString) + '.pas')
        else
          VEntidade.Lines.SaveToFile(edtPath.Text + 'Table.' + UpperCase(qryLista_TabelasTABELA.asString) + '.pas');
      end;
    end;
  end;

  ShowMessage('Arquivos gerados com sucesso');
end;

end.
