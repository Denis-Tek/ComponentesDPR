unit ComponentesDPR;

interface

uses Classes, DB, Forms, ExtCtrls, Mask, Controls, SysUtils, Windows, StdCtrls,
     MaskUtils, DBGrids, Graphics, ShellApi, ComCtrls, Menus, Messages, DBClient,
     Math, Types, UITypes, JvGradient, JvPanel;

type
  TTipoCaracter = (tcNormal, tcMaiusculo, tcMinusculo);
  PonteiroMeuRegistro = ^TMeuRegistro;
  TMeuRegistro = record
    FMenu: TMenuItem;
    FTabSheet: TTabSheet;
  end;

  TPesquisa = class(TComponent)
  private
    FAutor, FTitulo, FCampo: String;
    FEsquerda, FTopo: Integer;
    FMascara: TEditMask;
    FDataSet: TDataSet;
    FTipoCaracter: TTipoCaracter;
    FPosicao: TPosition;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure MaskEditChange(Sender: TObject);
    procedure SetAutor(const C: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    Pesquisar: Boolean;
  published
    property Autor:         String        read FAutor         write SetAutor;
    property Campo:         String        read FCampo         write FCampo;
    property DataSet:       TDataSet      read FDataSet       write FDataSet;
    property Esquerda:      Integer       read FEsquerda      write FEsquerda;
    property Mascara:       TEditMask     read FMascara       write FMascara;
    property Posicao:       TPosition     read FPosicao       write FPosicao;
    property TipoCaracter:  TTipoCaracter read FTipoCaracter  write FTipoCaracter;
    property Titulo:        String        read FTitulo        write FTitulo;
    property Topo:          Integer       read FTopo          write FTopo;
  end;

  TGridParaHTML = class(TComponent)
  private
    FAutor, FTitulo, FArquivo, FRodape: String;
    FDBGrid: TDBGrid;
    FVisualizar, FCorpoFontePadrao, FCabecalhoFontePadrao: Boolean;
    procedure SetAutor(const C: String);
    procedure SetArquivo(const C: String);
    function  DBGridToHtmlTable(mDBGrid: TDBGrid; mStrings: TStrings; mCaption: TCaption = ''; mRodape: TCaption = ''): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    Executar: Boolean;
  published
    property Autor:           String       read FAutor                write SetAutor;
    property Arquivo:         String       read FArquivo              write SetArquivo;
    property DBGrid:          TDBGrid      read FDBGrid               write FDBGrid;
    property Rodape:          String       read FRodape               write FRodape;
    property Titulo:          String       read FTitulo               write FTitulo;
    property Visualizar:      Boolean      read FVisualizar           write FVisualizar;
    property CorpoFontePadrao: Boolean     read FCorpoFontePadrao     write FCorpoFontePadrao;
    property CabecalhoFontePadrao: Boolean read FCabecalhoFontePadrao write FCabecalhoFontePadrao;
  end;

  TDataSetParaCSV = class(TComponent)
  private
    FAutor, FArquivoBase, FSeparador, FDelimitador, FExtensao: String;
    FDataSet: TDataSet;
    FDoInicio: Boolean;
    FMaximoRegistrosPorArquivo: Integer;
    procedure SetAutor(const C: String);
    procedure SetArquivoBase(const C: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    Executar: Boolean;
  published
    property Autor:                     String   read FAutor                     write SetAutor;
    property ArquivoBase:               String   read FArquivoBase               write SetArquivoBase;
    property DataSet:                   TDataSet read FDataSet                   write FDataSet;
    property Delimitador:               String   read FDelimitador               write FDelimitador;
    property DoInicio:                  Boolean  read FDoInicio                  write FDoInicio;
    property Extensao:                  String   read FExtensao                  write FExtensao;
    property Separador:                 String   read FSeparador                 write FSeparador;
    property MaximoRegistrosPorArquivo: Integer  read FMaximoRegistrosPorArquivo write FMaximoRegistrosPorArquivo;
  end;

  TTreeViewDPR = class(TTreeView)
  private
    FAutor: String;
    FMenuPrincipal: TMainMenu;
    FPageControl: TPageControl;
    FExpandir1, FRecolherAntesPosicionar, FUsarImagensDoMenu, FOrdenar,
    FPosicionarPageControlChange: Boolean;
    FIndexImagemPasta, FIndexImagemArquivo, FIndexImagemPastaSelec, FIndexImagemArquivoSelec: Integer;
    FEventoAoPosicionar: TNotifyEvent;
    procedure SetAutor(const C: String);
    procedure SetMenuPrincipal(M: TMainMenu);
    procedure SetPageControl(P: TPageControl);
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure LimparPonteirosUsados;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Change(Node: TTreeNode); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    
    procedure   Preenche;
    function    Posicionar(Sender: TObject; ExecutarChange: Boolean = True): Boolean;
    procedure   MoverTreeNodePeloTabSheet(TabSheetAMover, NovaTabSheePai: TTabSheet);
    function    MenuItemPeloNo: TMenuItem;
    procedure   LimparItems;
  published
    property Autor:                   String       read FAutor                   write SetAutor;
    property ExpandirPrimeiroNivel:   Boolean      read FExpandir1               write FExpandir1                default True;
    property MenuPrincipal:           TMainMenu    read FMenuPrincipal           write SetMenuPrincipal;
    property PageControl:             TPageControl read FPageControl             write SetPageControl;
    property RecolherAntesPosicionar: Boolean      read FRecolherAntesPosicionar write FRecolherAntesPosicionar  default False;
    property IndexImagemPasta:        Integer      read FIndexImagemPasta        write FIndexImagemPasta         default 0;
    property IndexImagemArquivo:      Integer      read FIndexImagemArquivo      write FIndexImagemArquivo       default 1;
    property IndexImagemPastaSelec:   Integer      read FIndexImagemPastaSelec   write FIndexImagemPastaSelec    default 2;
    property IndexImagemArquivoSelec: Integer      read FIndexImagemArquivoSelec write FIndexImagemArquivoSelec  default 3;
    property Ordenar:                 Boolean      read FOrdenar                 write FOrdenar                  default False;
    property UsarImagensDoMenu:       Boolean      read FUsarImagensDoMenu       write FUsarImagensDoMenu        default False;

    property AoPosicionar: TNotifyEvent read FEventoAoPosicionar write FEventoAoPosicionar;
  end;

  TIndicadorDPR = class(TCustomPanel)
  private
    JvGradientEsquerdo: TJvGradient;
    JvGradientCentro:   TJvGradient;
    JvGradientDireito: TJvGradient;
    ShapeMarcador: TShape;
    JvPanelTransparente: TJvPanel;
    JvPanelTransparente2: TJvPanel;
    PanelDescricao: TPanel;

    FAutor: string;
    FDescricao: string;

    FValorMaximo: Currency;
    FValorAtual: Currency;
    FValorMinimo: Currency;

    FCorEsquerda: TColor;
    FCorMeio: TColor;
    FCorDireita: TColor;
    FValorLimiteSuperiorMeio: Currency;
    FValorLimiteInferiorMeio: Currency;
    FExibirValorAtual: Boolean;
    FGradient: Boolean;

    procedure AjustarCores;
    procedure AjustarMeio;
    procedure AjustarPosicionamento;
    procedure AtualizarHeightPanelTransparente;
    procedure AtualizarHeightPanelTransparente2;
    procedure AtualizarExibicaoValorAtual;
    procedure RefreshCorrecao;

    procedure SetAutor(const Value: string);
    procedure SetDescricao(const Value: string);
    procedure SetValorAtual(const Value: Currency);
    procedure SetValorMaximo(const Value: Currency);
    procedure SetValorMinimo(const Value: Currency);
    procedure SetValorLimiteInferiorMeio(const Value: Currency);
    procedure SetValorLimiteSuperiorMeio(const Value: Currency);
    procedure SetAlturaPainelDescricao(const Value: Integer);
    procedure SetFontPainelDescricao(const Value: TFont);
    procedure SetFontPainelValorAtual(const Value: TFont);
    procedure SetCorDireita(const Value: TColor);
    procedure SetCorMeio(const Value: TColor);
    procedure SetCorEsquerda(const Value: TColor);
    procedure SetExibirValorAtual(const Value: Boolean);
    procedure SetGradient(const Value: Boolean);
    procedure SetLarguraMarcador(const Value: Integer);
    procedure SetEspessuraLinhaMarcador(const Value: Integer);

    function GetAlturaPainelDescricao: Integer;
    function GetFontPainelDescricao: TFont;
    function GetFontPainelValorAtual: TFont;
    function GetLarguraMarcador: Integer;
    function GetEspessuraLinhaMarcador: Integer;
  protected
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Imagem(out BMP: TBitMap);
  published
    property Autor:     string read FAutor     write SetAutor;
    property Descricao: string read FDescricao write SetDescricao;

    property ValorMinimo: Currency             read FValorMinimo             write SetValorMinimo;
    property ValorMaximo: Currency             read FValorMaximo             write SetValorMaximo;
    property ValorAtual:  Currency             read FValorAtual              write SetValorAtual;
    property ValorLimiteInferiorMeio: Currency read FValorLimiteInferiorMeio write SetValorLimiteInferiorMeio;
    property ValorLimiteSuperiorMeio: Currency read FValorLimiteSuperiorMeio write SetValorLimiteSuperiorMeio;        

    property CorDireita:  TColor read FCorDireita  write SetCorDireita  default clLime;
    property CorMeio:     TColor read FCorMeio     write SetCorMeio     default clYellow;
    property CorEsquerda: TColor read FCorEsquerda write SetCorEsquerda default clRed;

    property FontPainelDescricao:  TFont read GetFontPainelDescricao  write SetFontPainelDescricao;
    property FontPainelValorAtual: TFont read GetFontPainelValorAtual write SetFontPainelValorAtual;

    property AlturaPainelDescricao: Integer  read GetAlturaPainelDescricao  write SetAlturaPainelDescricao;
    property LarguraMarcador: Integer        read GetLarguraMarcador        write SetLarguraMarcador;
    property EspessuraLinhaMarcador: Integer read GetEspessuraLinhaMarcador write SetEspessuraLinhaMarcador;

    property ExibirValorAtual: Boolean read FExibirValorAtual write SetExibirValorAtual;
    property Gradient: Boolean         read FGradient         write SetGradient;    

    // publicando algumas propriedades de TPanel
    property Align;
    property Anchors;

{   // Essas propriedades não foram liberadas, pois davam problema ao desenhar os componentes,
    // Se quiser mais detalhes no indicador, coloque um panel por baixo dele e ajuste essas propriedades do panel
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
}
    property Color;
    property Constraints;
    property PopupMenu;
    property ShowHint;
    property Visible;

    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
  end;

  procedure Register;
  function  ColorToHtml(mColor: TColor): string;
  function  StrToHtml(mStr: string; mFont: TFont = nil): string;
  function  RetiraEComercial(S: String): String;
  function  iif(Condicao: Boolean; ResultadoVerdadeiro, ResultadoFalso: Variant): Variant;

const
  C_Autor = 'Denis Pereira Raymundo';

var
  Contato: String;

implementation

{$region 'Funções Genéricas'}
procedure Register;
begin
  RegisterComponents('DenisPR',[TPesquisa, TGridParaHTML, TTreeViewDPR, TDataSetParaCSV, TIndicadorDPR]);
end;

function iif(Condicao: Boolean; ResultadoVerdadeiro, ResultadoFalso: Variant): Variant;
begin
  if Condicao then
    Result := ResultadoVerdadeiro
  else
    Result := ResultadoFalso;
end;

function RetiraEComercial(S: String): String;
begin
  Result := StringReplace(S, '&', '', [rfReplaceAll]);
end;

function ColorToHtml(mColor: TColor): string;
begin
  mColor := ColorToRGB(mColor);
  Result := Format('#%.2x%.2x%.2x', [GetRValue(mColor), GetGValue(mColor), GetBValue(mColor)]);
end;

function StrToHtml(mStr: string; mFont: TFont = nil): string;
var vLeft, vRight: string;
begin
  Result := mStr;
  Result := StringReplace(Result, '&', '&AMP;',  [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&LT;',   [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&GT;',   [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '&nbsp;', [rfReplaceAll]);
  if Trim(Result) = '' then Result := '&nbsp;';
  if not Assigned(mFont) then Exit;
  vLeft  := Format('<FONT SIZE=1 FACE="%s" COLOR="%s">', [mFont.Name, ColorToHtml(mFont.Color)]);
  vRight := '</FONT>';
  if fsBold in mFont.Style then
    begin
      vLeft := vLeft + '<B>';
      vRight := '</B>' + vRight;
    end;
  if fsItalic in mFont.Style then
    begin
      vLeft := vLeft + '<I>';
      vRight := '</I>' + vRight;
    end;
  if fsUnderline in mFont.Style then
    begin
      vLeft := vLeft + '<U>';
      vRight := '</U>' + vRight;
    end;
  if fsStrikeOut in mFont.Style then
    begin
      vLeft := vLeft + '<S>';
      vRight := '</S>' + vRight;
    end;
  Result := vLeft + Result + vRight;
end;
{$endregion}

{$region 'Implementação do Componente TPesquisa'}
constructor TPesquisa.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FAutor   := C_Autor;
   FPosicao := poScreenCenter;
end;

destructor TPesquisa.Destroy;
begin
   inherited Destroy;
end;

procedure TPesquisa.SetAutor(const C: String);
begin
  if C <> FAutor then
    Application.MessageBox(PChar(Contato), 'Contato', mb_Ok);
end;

function TPesquisa.Pesquisar: Boolean;
var
  F: TForm;
  P: TPanel;
  M: TMaskEdit;
  FocoAnterior: TWinControl;
  ASTemp, BSTemp: TDataSetNotifyEvent;
  RegistroAtual: Integer;
begin
  Result := False;
  if (FDataSet = nil) or (not FDataSet.Active) then Exit;

  Application.CreateForm(TForm, F);

  // Desativando eventos de rolagem
  with FDataSet do
    begin
      ASTemp        := AfterScroll;
      BSTemp        := BeforeScroll;
      AfterScroll   := nil;
      BeforeScroll  := nil;
      RegistroAtual := RecNo;
    end;

  with F do
    try
      if fTitulo = '' then
        Caption := 'Pesquisa'
      else
        Caption := 'Pesquisar por ' + FTitulo;
      BorderStyle := bsSingle;
      Position    := FPosicao;
      BorderIcons := [biSystemMenu];
      Height      := 81;
      Left        := FEsquerda;
      KeyPreview  := True;
      Top         := FTopo;
      Width       := 364;
      OnKeyDown   := FormKeyDown;
      OnShow      := FormShow;

      P := TPanel.Create(F);
      with P do
        begin
          Align      := alClient;
          Caption    := '';
          BevelInner := bvLowered;
          BevelOuter := bvLowered;
          Parent     := F;
        end;

      M := TMaskEdit.Create(F);
      with M do
        begin
          Name     := 'MaskEditPesquisaIncremental';
          CharCase := TEditCharCase(FTipoCaracter);
          EditMask := FMascara;
          Parent   := P;
          Top      := 18;
          Left     := 57;
          Width    := 250;
          MaxLength := 50;
          Clear;
          OnChange := MaskEditChange;
        end;

      FocoAnterior  := Screen.ActiveForm.ActiveControl;
      Result := (ShowModal = mrOk);
      Screen.ActiveForm.ActiveControl := FocoAnterior;
    finally
      Free;

      // retornando eventos e executando apenas uma vez caso necessário
      with FDataSet do
        begin
          AfterScroll  := ASTemp;
          BeforeScroll := BSTemp;
          if (RegistroAtual <> RecNo) then
            begin
              if Assigned(BeforeScroll) then
                BeforeScroll(FDataSet);

              if Assigned(AfterScroll) then
                AfterScroll(FDataSet);
            end;
        end;

    end;
end;

procedure TPesquisa.MaskEditChange(Sender: TObject);
var
  S: String;
  Conteudo: Variant;
  ComLocate, Descendente: Boolean;
begin
  S := TrimRight(TMaskEdit(Sender).Text);

  with FDataSet do
    if (S <> '') and
       (( (FieldByName(FCampo).DataType in [ftDate,     ftTimeStamp]) and (Length(S) = 10) and (S <> '/  /') )  or
        ( (FieldByName(FCampo).DataType in [ftDateTime, ftTimeStamp]) and (Length(Trim(Copy(S, 1, 10))) = 10) ) or
        ( (FieldByName(FCampo).DataType in [ftTime,     ftTimeStamp]) and (Length(S) = 8)  and (S <> ':  :') )  or
        (not (FieldByName(FCampo).DataType in [ftDate, ftTime, ftTimeStamp]))) then
      try
        DisableControls;

        ComLocate := True;

        Conteudo := TMaskEdit(Sender).Text;
        try
          case FieldByName(FCampo).DataType of
            ftInteger: StrToInt(TMaskEdit(Sender).Text);
            ftFMTBCD:
              begin
                if (FieldByName(FCampo).Size = 0) then
                  StrToInt64(TMaskEdit(Sender).Text)
                else
                  Conteudo := StrToFloat(TMaskEdit(Sender).Text);
              end;
            ftDate, ftDateTime, ftTime, ftTimeStamp:
              begin
                if (Pos('99/99/9999 99:99:99', FieldByName(FCampo).EditMask) = 1) and (Length(Trim(Copy(S, 1, 10))) = 10) then
                  Conteudo := StrToDateTime(Trim(Copy(S, 1, 10)))
                else
                  Conteudo := StrToDateTime(TMaskEdit(Sender).Text);
              end;
          end;
        except
          on E: EConvertError do
            begin
              Application.MessageBox('Conteúdo a pesquisar é inválido para o tipo de campo', 'Informação', mb_Ok);
              //TMaskEdit(Sender).Clear;
              //TMaskEdit(Sender).SelectAll;
              Abort;
            end;
        end;

        if (FDataSet is TClientDataSet) and
           (TClientDataSet(FDataSet).IndexName = FCampo) then
          begin
            try
              // Se o Indice não existir vai dar erro
              TClientDataSet(FDataSet).IndexDefs.Update;
              Descendente := (ixDescending in TClientDataSet(FDataSet).IndexDefs.Find(FCampo).Options);
              if (not Descendente) then
                begin
                  TClientDataSet(FDataSet).FindNearest([Conteudo]);
                  ComLocate := False;
                end;
            except
            end;
          end;

        if ComLocate then
          try
            Locate(FCampo, Conteudo, [loPartialKey, loCaseInsensitive]);
          except
            on E: Exception do
              begin
                if (Pos('field', LowerCase(E.Message)) = 1) and
                   (Pos('cannot be used in a filter expression', LowerCase(E.Message)) > 0) then
                  Application.MessageBox('Não é possível pesquisar por este campo neste local. Ele deve ser originário de outra tabela.', 'Informação', mb_Ok)
                else
                  raise;
              end;
          end;
      finally
        EnableControls;
      end;
end;

procedure TPesquisa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = []) and (Key = vk_Return) then TForm(Sender).ModalResult := mrOk;
  if (Shift = []) and (Key = vk_Escape) then TForm(Sender).ModalResult := mrCancel;
end;

procedure TPesquisa.FormShow(Sender: TObject);
begin
  // Gambiarra para apresentar o cursor piscando, mas muda o componente ativo
  // Screen.ActiveForm.Perform(WM_NEXTDLGCTL, 0, 0);
end;
{$endregion}

{$region 'Implementação do Componente TGridParaHTML'}
constructor TGridParaHTML.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FAutor := C_Autor;
   FCorpoFontePadrao     := False;
   FCabecalhoFontePadrao := False;
end;

destructor TGridParaHTML.Destroy;
begin
   inherited Destroy;
end;

procedure TGridParaHTML.SetAutor(const C: String);
begin
  if C <> FAutor then
    Application.MessageBox(PChar(Contato), 'Contato', mb_Ok);
end;

procedure TGridParaHTML.SetArquivo(const C: String);
begin
  FArquivo := ChangeFileExt(C, '.HTM');
end;

function TGridParaHTML.Executar: Boolean;
var S: TStrings; C: TCursor;
begin
  C := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  S := TStringList.Create;
  try
    DBGridToHtmlTable(FDBGrid, S, FTitulo, FRodape);
    S.SaveToFile(FArquivo);
    if FVisualizar then
      ShellExecute(0, nil, PChar(FArquivo), nil, nil, SW_SHOW)
    else
      Application.MessageBox(PChar(AnsiUpperCase(FArquivo) + ' gerado com sucesso'), 'Término de Processo', mb_Ok);
    Result := True;
  finally
    S.Free;
    Screen.Cursor := C;
  end;
end;

function TGridParaHTML.DBGridToHtmlTable(mDBGrid: TDBGrid; mStrings: TStrings; mCaption: TCaption = ''; mRodape: TCaption = ''): Boolean;
const
  cAlignText: array[TAlignment] of string = ('LEFT', 'RIGHT', 'CENTER');
var
  vColFormat, vColText: string;
  vAllWidth, I, J, Reg: Integer;
  vWidths: array of Integer;
  GridAtiva: Boolean;
  SLTemp: TStrings;
  vBookmark: TBookmark;
begin
  Result := False;
  if not Assigned(mStrings) then Exit;
  if not Assigned(mDBGrid) then Exit;
  if not Assigned(mDBGrid.DataSource) then Exit;
  if not Assigned(mDBGrid.DataSource.DataSet) then Exit;
  if not mDBGrid.DataSource.DataSet.Active then Exit;

  vBookmark := mDBGrid.DataSource.DataSet.Bookmark;
  mDBGrid.DataSource.DataSet.DisableControls;
  GridAtiva := mDBGrid.Enabled;
  mDBGrid.Enabled := False;
  SLTemp := TStringList.Create;
  try
    J := 0;
    vAllWidth := 0;
    for I := 0 to mDBGrid.Columns.Count - 1 do
      if mDBGrid.Columns[I].Visible then
        begin
          Inc(J);
          SetLength(vWidths, J);
          vWidths[J - 1] := mDBGrid.Columns[I].Width;
          Inc(vAllWidth, mDBGrid.Columns[I].Width);
        end;
    if J <= 0 then Exit;
    mStrings.Clear;
    mStrings.Add(Format('<HTML><HEADER><TITLE>%s</TITLE>', [StrToHtml(mCaption)]));
    mStrings.Add('<style type="text/css"><!--');
    mStrings.Add('     .t{border-top:    1px solid #000000; border-right: 1px solid #000000;');
    mStrings.Add('        border-bottom: 1px solid #000000; border-left:  1px solid #000000;}');
    mStrings.Add('     .d{border-top:    1px none;          border-right: 1px solid #C0C0C0;');
    mStrings.Add('        border-bottom: 1px solid #C0C0C0; border-left:  1px none;');
    mStrings.Add('        font-family:   "MS Sans Serif", Times, serif; font-size:  8px; color: #000000; background-color: #FFFFFF;}');
    mStrings.Add('     .c{border-top:    1px none;          border-right: 1px solid #000000;');
    mStrings.Add('        border-bottom: 1px solid #000000; border-left:  1px none;');
    mStrings.Add('        font-family: Tahoma, Times, serif;            font-size: 11px; color: #000000; background-color: #9CC99C; font-weight: bold; text-align: center;}');
    mStrings.Add('--> </style></HEADER><BODY>');
    mStrings.Add(Format('<TABLE CLASS="t" BGCOLOR="%s" WIDTH="100%%" CELLSPACING=0 BORDERCOLOR="#C0C0C0">', [ColorToHtml(mDBGrid.Color)]));
    if mCaption <> '' then
       mStrings.Add(Format('<CAPTION><FONT FACE="Tahoma" COLOR="%S"><B>%s</FONT></B></CAPTION>', [ColorToHtml(clBlack), StrToHtml(mCaption)]));
    vColFormat := '<TR>'#13#10;
    vColText   := '<TR>'#13#10;
    J := 0;
    for I := 0 to mDBGrid.Columns.Count - 1 do
      if mDBGrid.Columns[I].Visible then
        begin
          if FCorpoFontePadrao then
            vColFormat := vColFormat + Format(
              '  <TD CLASS="d" ALIGN=%s>DisplayText%d</TD>'#13#10,
              [cAlignText[mDBGrid.Columns[I].Alignment], J])
          else
            vColFormat := vColFormat + Format(
              '  <TD CLASS="d" BGCOLOR="%s" ALIGN=%s WIDTH="%d%%">DisplayText%d</TD>'#13#10,
              [ColorToHtml(mDBGrid.Columns[I].Color),
              cAlignText[mDBGrid.Columns[I].Alignment],
              Round(vWidths[J] / vAllWidth * 100), J]);

          if FCabecalhoFontePadrao then
            vColText := vColText + Format(
              '  <TD CLASS="c" WIDTH="%d%%">%s</TD>'#13#10,
              [Round(vWidths[J] / vAllWidth * 100),
              StrToHtml(mDBGrid.Columns[I].Title.Caption)])
          else
            vColText := vColText + Format(
              '  <TD CLASS="c" BGCOLOR="%s" ALIGN=%s WIDTH="%d%%">%s</TD>'#13#10,
              [ColorToHtml(mDBGrid.Columns[I].Title.Color),
              cAlignText[mDBGrid.Columns[I].Title.Alignment],
              Round(vWidths[J] / vAllWidth * 100),
              StrToHtml(mDBGrid.Columns[I].Title.Caption,
              mDBGrid.Columns[I].Title.Font)]);

          Inc(J);
        end;
    vColFormat    := vColFormat + '</TR>'#13#10;
    vColText      := vColText + '</TR>'#13#10;
    mStrings.Text := mStrings.Text + vColText;
    mDBGrid.DataSource.DataSet.First;
    Reg := 0;
    while not mDBGrid.DataSource.DataSet.Eof do
      begin
        Inc(Reg);
        if (Reg mod 1000) = 0 then
          begin
            Reg := 0;
//            mDBGrid.DataSource.DataSet.EnableControls;
//            mDBGrid.DataSource.DataSet.DisableControls;
            Application.ProcessMessages;
          end;
        J := 0;
        vColText := vColFormat;
        for I := 0 to mDBGrid.Columns.Count - 1 do
          if mDBGrid.Columns[I].Visible then
            begin
              if FCorpoFontePadrao then
                vColText := StringReplace(vColText, Format('>DisplayText%d<', [J]),
                   Format('>%s<', [StrToHtml(mDBGrid.Columns[I].Field.DisplayText)]), [rfReplaceAll])
              else
                vColText := StringReplace(vColText, Format('>DisplayText%d<', [J]),
                   Format('>%s<', [StrToHtml(mDBGrid.Columns[I].Field.DisplayText, mDBGrid.Columns[I].Font)]), [rfReplaceAll]);
              Inc(J);
            end;
//        mStrings.Text := mStrings.Text + vColText;
        mStrings.Add(vColText);
        mDBGrid.DataSource.DataSet.Next;
      end;
    mStrings.Add('</TABLE>');
    mStrings.Add(Format('<CENTER><FONT FACE="Arial" SIZE=0 COLOR="%s"><B><I>%s</B></I></FONT>', [ColorToHtml(clNavy), mRodape]));
    mStrings.Add('</BODY></HTML>');
  finally
    mDBGrid.DataSource.DataSet.Bookmark := vBookmark;
    mDBGrid.DataSource.DataSet.EnableControls;
    mDBGrid.Enabled := GridAtiva;
    vWidths := nil;
    SLTemp.Free;
  end;
  Result := True;
end;
{$endregion}

{$region 'Implementação do Componente TTreeViewDPR'}
constructor TTreeViewDPR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutor                   := C_Autor;
  FOrdenar                 := False;
  FExpandir1               := True;
  FIndexImagemPasta        := 0;
  FIndexImagemArquivo      := 1;
  FIndexImagemPastaSelec   := 2;
  FIndexImagemArquivoSelec := 3;
  FRecolherAntesPosicionar := False;
  FPosicionarPageControlChange := True;
  FMenuPrincipal := nil;
  FPageControl := nil;
  ReadOnly := True;
  HotTrack := True;
  Align    := alLeft;
end;

destructor TTreeViewDPR.Destroy;
begin
  LimparPonteirosUsados;
  inherited Destroy;
end;

procedure TTreeViewDPR.SetAutor(const C: String);
begin
  if C <> FAutor then
    Application.MessageBox(PChar(Contato), 'Contato', mb_Ok);
end;

procedure TTreeViewDPR.SetPageControl(P: TPageControl);
begin
  FPageControl := P;
  FMenuPrincipal := nil;
  Self.Items.Clear;
end;

procedure TTreeViewDPR.SetMenuPrincipal(M: TMainMenu);
begin
  FMenuPrincipal := M;
  FPageControl := nil;
  Self.Items.Clear;
end;

procedure TTreeViewDPR.Preenche;
var
  x1, x2, x3, x4: integer;
  T1, T2, T3, T4: TTreeNode;
  MeuRegistro: PonteiroMeuRegistro;
begin
  LimparPonteirosUsados;

  if Assigned(FMenuPrincipal) then
    with FMenuPrincipal do
      begin
        Self.Invalidate;
        Self.Items.Clear;
        // Primeiro nivel
        for x1 := 0 to Items.Count - 1 do
          if (Items[x1].Visible) and
             (Items[x1].Enabled) and
             (Items[x1].Caption <> '-') then
            begin
              New(MeuRegistro);
              MeuRegistro^.FMenu := Items[x1];
              T1 := Self.Items.AddObject(nil, RetiraEComercial(MeuRegistro^.FMenu.Caption), MeuRegistro);
              if FUsarImagensDoMenu then
                begin
                  T1.ImageIndex    := MeuRegistro^.FMenu.ImageIndex;
                  T1.SelectedIndex := MeuRegistro^.FMenu.ImageIndex;
                end
              else
                begin
                  if Items[x1].Count = 0 then
                    begin
                      T1.ImageIndex    := FIndexImagemArquivo;
                      T1.SelectedIndex := FIndexImagemArquivoSelec;
                    end
                  else
                    begin
                      T1.ImageIndex    := FIndexImagemPasta;
                      T1.SelectedIndex := FIndexImagemPastaSelec;
                    end;
                end;

              // Segundo nivel
              for x2 := 0 to Items[x1].Count - 1 do
                if (Items[x1].Items[x2].Visible) and
                   (Items[x1].Items[x2].Enabled) and
                   (Items[x1].Items[x2].Caption <> '-') then
                  begin
                    New(MeuRegistro);
                    MeuRegistro^.FMenu := Items[x1].Items[x2];
                    T2 := Self.Items.AddChildObject(T1, RetiraEComercial(MeuRegistro^.FMenu.Caption), MeuRegistro);
                    if FUsarImagensDoMenu then
                      begin
                        T2.ImageIndex    := MeuRegistro^.FMenu.ImageIndex;
                        T2.SelectedIndex := MeuRegistro^.FMenu.ImageIndex;
                      end
                    else
                      begin
                        if Items[x1].Items[x2].Count = 0 then
                          begin
                            T2.ImageIndex    := FIndexImagemArquivo;
                            T2.SelectedIndex := FIndexImagemArquivoSelec;
                          end
                        else
                          begin
                            T2.ImageIndex    := FIndexImagemPasta;
                            T2.SelectedIndex := FIndexImagemPastaSelec;
                          end;
                      end;

                    // Terceiro nível
                    for x3 := 0 to Items[x1].Items[x2].Count - 1 do
                      if (Items[x1].Items[x2].Items[x3].Visible) and
                         (Items[x1].Items[x2].Items[x3].Enabled) and
                         (Items[x1].Items[x2].Items[x3].Caption <> '-') then
                        begin
                          New(MeuRegistro);
                          MeuRegistro^.FMenu := Items[x1].Items[x2].Items[x3];
                          T3 := Self.Items.AddChildObject(T2, RetiraEComercial(MeuRegistro^.FMenu.Caption), MeuRegistro);
                          if FUsarImagensDoMenu then
                            begin
                              T3.ImageIndex    := MeuRegistro^.FMenu.ImageIndex;
                              T3.SelectedIndex := MeuRegistro^.FMenu.ImageIndex;
                            end
                          else
                            begin
                              if Items[x1].Items[x2].Items[x3].Count = 0 then
                                begin
                                  T3.ImageIndex    := FIndexImagemArquivo;
                                  T3.SelectedIndex := FIndexImagemArquivoSelec;
                                end
                              else
                                begin
                                  T3.ImageIndex    := FIndexImagemPasta;
                                  T3.SelectedIndex := FIndexImagemPastaSelec;
                                end;
                            end;

                          // Quarto nível
                          for x4 := 0 to Items[x1].Items[x2].Items[x3].Count - 1 do
                            if (Items[x1].Items[x2].Items[x3].Items[x4].Visible) and
                               (Items[x1].Items[x2].Items[x3].Items[x4].Enabled) and
                               (Items[x1].Items[x2].Items[x3].Items[x4].Caption <> '-') then
                              begin
                                New(MeuRegistro);
                                MeuRegistro^.FMenu := Items[x1].Items[x2].Items[x3].Items[x4];
                                T4 := Self.Items.AddChildObject(T3, RetiraEComercial(MeuRegistro^.FMenu.Caption), MeuRegistro);
                                if FUsarImagensDoMenu then
                                  begin
                                    T4.ImageIndex    := MeuRegistro^.FMenu.ImageIndex;
                                    T4.SelectedIndex := MeuRegistro^.FMenu.ImageIndex;
                                  end
                                else
                                  begin
                                    if Items[x1].Items[x2].Items[x3].Items[x4].Count = 0 then
                                      begin
                                        T4.ImageIndex    := FIndexImagemArquivo;
                                        T4.SelectedIndex := FIndexImagemArquivoSelec;
                                      end
                                    else
                                      begin
                                        T4.ImageIndex    := FIndexImagemPasta;
                                        T4.SelectedIndex := FIndexImagemPastaSelec;
                                      end;
                                  end;
                              end;
                        end;
                  end;
            end;
        Self.Repaint;
      end

  else if Assigned(FPageControl) then
    with FPageControl do
      try
        FPosicionarPageControlChange := False;
        Self.Invalidate;
        Self.Items.Clear;
        for x1 := 0 to PageCount - 1 do
          if (Pages[x1].Enabled) then
            begin
              New(MeuRegistro);
              MeuRegistro^.FTabSheet := Pages[x1];
              T1 := Self.Items.AddObject(nil, MeuRegistro^.FTabSheet.Caption, MeuRegistro);
              T1.ImageIndex    := FIndexImagemArquivo;
              T1.SelectedIndex := FIndexImagemArquivoSelec;
            end;
        Self.Repaint;
      finally
        FPosicionarPageControlChange := True;
      end;

  try
    FPosicionarPageControlChange := False;

    if FOrdenar then
      Self.Items.AlphaSort(True);

    // Expandindo 1 nivel
    if FExpandir1 then
      with Self do
        for x1 := 0 to Items.Count - 1 do
          if Items[x1].Level = 0 then Items[x1].Expand(False);
  finally
    FPosicionarPageControlChange := True;
  end;
end;

function TTreeViewDPR.Posicionar(Sender: TObject; ExecutarChange: Boolean = True): Boolean;
var x: Integer;
begin
  Result := False;

  if FRecolherAntesPosicionar then Self.FullCollapse;

  if Assigned(FMenuPrincipal) and (Sender is TMenuItem) then
    with Self do
      for x := 0 to Items.Count -1 do
        if (PonteiroMeuRegistro(Items[x].Data)^.FMenu = (Sender as TMenuItem)) then
          begin
            Select(Items[x], []);
            Result := True;
            Break;
          end;
          
  if Assigned(FPageControl) and (Sender is TTabSheet) then
    with Self do
      try
        FPosicionarPageControlChange := False;
        for x := 0 to Items.Count -1 do
          if (PonteiroMeuRegistro(Items[x].Data)^.FTabSheet = (Sender as TTabSheet)) then
            begin
              Select(Items[x], []);
              Result := True;
              Break;
            end;
      finally
        FPosicionarPageControlChange := True;
        if ExecutarChange then Change(Self.Selected);
      end;

  if Assigned(FEventoAoPosicionar) then
    FEventoAoPosicionar(Sender);
end;

procedure TTreeViewDPR.WMLButtonUp(var Message: TWMLButtonUp);
var MousePos: TPoint; ANode: TTreeNode;
begin
  // Interceptando o botão ESQUERDO do mouse
  inherited;
  if GetCursorPos(MousePos) then
    begin
      MousePos := Self.ScreenToClient(MousePos);
      ANode    := Self.GetNodeAt(MousePos.x, MousePos.y);
      if (ANode <> nil) and (Self.Selected <> nil) then
        if (ANode.Text = Self.Selected.Text) then
          begin
            if Assigned(FMenuPrincipal) then
              PonteiroMeuRegistro(Selected.Data)^.FMenu.Click;
          end
     end
end;

procedure TTreeViewDPR.WMRButtonUp(var Message: TWMRButtonUp);
var MousePos: TPoint; ANode: TTreeNode;
begin       
  // Interceptando o botão DIREITO do mouse
  inherited;
  if GetCursorPos(MousePos) then
    begin
      MousePos := Self.ScreenToClient(MousePos);
      ANode    := Self.GetNodeAt(MousePos.x, MousePos.y);
      if (ANode <> nil) and (Self.Selected <> nil) then
        Self.Selected := ANode;
     end
end;

procedure TTreeViewDPR.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_return then
    begin
      if Assigned(FMenuPrincipal) and
        (Self.Selected <> nil) then
        PonteiroMeuRegistro(Selected.Data)^.FMenu.Click;
    end;
end;

procedure TTreeViewDPR.LimparItems;
begin
  LimparPonteirosUsados;
  Self.Items.Clear;
end;

procedure TTreeViewDPR.LimparPonteirosUsados;
var x: Integer;
begin
  for x := Self.Items.Count -1 downto 0 do
    Dispose(Self.Items[x].Data);
end;

procedure TTreeViewDPR.Change(Node: TTreeNode);
begin
  inherited;
  if Assigned(FPageControl) and (FPosicionarPageControlChange) then
    FPageControl.ActivePage := PonteiroMeuRegistro(Self.Selected.Data)^.FTabSheet;
end;

function TTreeViewDPR.MenuItemPeloNo: TMenuItem;
begin
  if (FMenuPrincipal <> nil) then
    Result := PonteiroMeuRegistro(Self.Selected.Data)^.FMenu
  else
    Result := nil;
end;

procedure TTreeViewDPR.MoverTreeNodePeloTabSheet(TabSheetAMover, NovaTabSheePai: TTabSheet);
var Orig, Dest, Novo: TTreeNode;
begin
  if TabSheetAMover = nil then Exit;

  if Self.Posicionar(TabSheetAMover, False) then
    Orig := Self.Selected
  else
    Exit;

  if Self.Posicionar(NovaTabSheePai, False) then
    Dest := Self.Selected
  else
    Dest := nil;

  try
    FPosicionarPageControlChange := False;
    if Dest = nil then
      Novo := Self.Items.AddObject(nil, Orig.Text, Orig.Data)
    else
      Novo := Self.Items.AddChildObject(Dest, Orig.Text, Orig.Data);

    Novo.ImageIndex    := Orig.ImageIndex;
    Novo.SelectedIndex := Orig.SelectedIndex;

    Self.Items.Delete(Orig);
  finally
    FPosicionarPageControlChange := True;
  end;
end;
{$endregion}

{$region 'Implementação do Componente TDataSetParaCSV'}
constructor TDataSetParaCSV.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutor                     := C_Autor;
  FDataSet                   := nil;
  FArquivoBase               := '';
  FDoInicio                  := True;
  FMaximoRegistrosPorArquivo := 0;
  FSeparador                 := ',';
  FExtensao                  := '.CSV';
  FDelimitador               := '"';
end;

destructor TDataSetParaCSV.Destroy;
begin
  inherited Destroy;
end;

function TDataSetParaCSV.Executar: Boolean;
  procedure Cabecalho(Lista: TStrings);
  var S: String; x: Integer;
  begin
    S := '';
    with FDataSet do
      for x := 0 to Fields.Count - 1 do
        if (not (Fields[x].DataType in [ftBlob, ftGraphic, ftMemo, ftFmtMemo])) then
          S := S + iif(S = '', '', FSeparador) + FDelimitador + Fields[x].FieldName + FDelimitador;
    Lista.Clear;
    Lista.Add(S);
  end;
var
  L: TStrings;
  x, y, Parte: Integer;
  S: String;
  C: TCursor;
  vBookmark: TBookmark;
begin
  Result := False;
  if (FDataSet = nil) or
     (FArquivoBase = '') or
     (not FDataSet.Active) then Exit;

  L := TStringList.Create;
  C := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    with FDataSet do
      begin
        DisableControls;
        vBookmark := Bookmark;

        if FDoInicio then First; // no caso do dataset ser unidirecional não pode se mover para traz

        Y := 1;
        Parte := 1;

        Cabecalho(L);

        while not Eof do
          begin
            // Controle de Múltiplos Arquivos
            if (FMaximoRegistrosPorArquivo <> 0) then
              begin
                Inc(Y);
                if (Y > FMaximoRegistrosPorArquivo) then
                  begin
                    L.SaveToFile(ChangeFileExt(FArquivoBase, '') + FormatCurr('#000', Parte) + FExtensao);
                    Y := 2;
                    Inc(Parte);
                    Cabecalho(L);
                  end;
              end;

            // Montagem da linha de dados
            S := '';
            for x := 0 to Fields.Count - 1 do
              if (not (Fields[x].DataType in [ftBlob, ftGraphic, ftMemo, ftFmtMemo])) then
                S := S + iif(S = '', '', FSeparador) + FDelimitador + StringReplace(Fields[x].AsString, '"', '""', [rfReplaceAll]) + FDelimitador;
            L.Add(S);

            Next;
          end;
      end;

    if (FMaximoRegistrosPorArquivo = 0) or (Parte = 1) then
      L.SaveToFile(FArquivoBase)
    else
      L.SaveToFile(ChangeFileExt(FArquivoBase, '') + FormatCurr('#000', Parte) + FExtensao);
    Result := True;      
  finally
    FDataSet.Bookmark := vBookmark;
    FDataSet.EnableControls;
    L.Free;
    Screen.Cursor := C;
  end;
end;

procedure TDataSetParaCSV.SetArquivoBase(const C: String);
begin
  FArquivoBase := ChangeFileExt(C, FExtensao);
end;

procedure TDataSetParaCSV.SetAutor(const C: String);
begin
  if C <> FAutor then
    Application.MessageBox(PChar(Contato), 'Contato', mb_Ok);
end;
{$endregion}

{$region 'Implementação do Componente TIndicadorDPR'}
constructor TIndicadorDPR.Create(AOwner: TComponent);
begin
  inherited;

  FAutor   := C_Autor;

  // Configurações Padrões
  Caption    := ' ';
  BevelOuter := bvLowered;
  Width      := 400;
  Height     := 34;

  FValorMinimo             := 0;
  FValorMaximo             := 100;
  FValorAtual              := 75;
  FValorLimiteInferiorMeio := 33;
  FValorLimiteSuperiorMeio := 66;

  FCorDireita  := clLime;
  FCorMeio     := clYellow;
  FCorEsquerda := clRed;

  FGradient    := True;

  // Primeira Camada
  PanelDescricao := TPanel.Create(Self);
  PanelDescricao.Align      := alBottom;
  PanelDescricao.Caption    := ' ';
  PanelDescricao.Height     := 18;
  PanelDescricao.BevelInner := bvLowered;
  PanelDescricao.Parent     := Self;

  JvGradientEsquerdo := TJvGradient.Create(Self);
  JvGradientEsquerdo.Width  := (Width div 2); // Numa escala normal, esse panel representa 50%
  JvGradientEsquerdo.Parent := Self;
  JvGradientEsquerdo.Align  := alLeft;

  JvGradientDireito := TJvGradient.Create(Self);
  JvGradientDireito.Width  := (Width div 2) - 1; // Numa escala normal, esse panel representa 50%
  JvGradientDireito.Parent := Self;
  JvGradientDireito.Align  := alRight;

  JvGradientCentro := TJvGradient.Create(Self); // Numa escala normal, esse panel não representa nada
  JvGradientCentro.Width  := 1;
  JvGradientCentro.Parent := Self;
  JvGradientCentro.Align  := alClient;

  // Segunda Camada (onde será plotado o Marcador)
  JvPanelTransparente := TJvPanel.Create(Self);
  JvPanelTransparente.Left        := 0;
  JvPanelTransparente.Top         := 0;
  JvPanelTransparente.Width       := Self.Width;
  JvPanelTransparente.Anchors     := [akLeft,akTop,akRight,akBottom];
  JvPanelTransparente.Transparent := True;
  JvPanelTransparente.BevelOuter  := bvNone;
  AtualizarHeightPanelTransparente;
  JvPanelTransparente.Parent      := Self;

  // Terceira Camada
  ShapeMarcador := TShape.Create(Self);
  ShapeMarcador.Brush.Color := clWhite;
  ShapeMarcador.Pen.Width   := 2;
  ShapeMarcador.Top         := 2;
  ShapeMarcador.Width       := 5;
  ShapeMarcador.Anchors     := [akTop,akBottom];
  ShapeMarcador.Parent      := JvPanelTransparente;

  // Quarta Camada (Onde será exibido o valor do indicador)
  JvPanelTransparente2 := TJvPanel.Create(Self);
  JvPanelTransparente2.Left        := 0;
  JvPanelTransparente2.Top         := 0;
  JvPanelTransparente2.Width       := Self.Width;
  JvPanelTransparente2.Anchors     := [akLeft,akTop,akRight,akBottom];
  JvPanelTransparente2.Transparent := True;
  JvPanelTransparente2.BevelOuter  := bvNone;
  AtualizarHeightPanelTransparente2;
  JvPanelTransparente2.Parent      := JvPanelTransparente;

  AjustarCores;
  AjustarPosicionamento;
  AtualizarExibicaoValorAtual;
end;

destructor TIndicadorDPR.Destroy;
begin
  PanelDescricao.Free;
  ShapeMarcador.Free;
  JvPanelTransparente2.Free;
  JvPanelTransparente.Free;
  JvGradientEsquerdo.Free;
  JvGradientDireito.Free;
  JvGradientCentro.Free;  
  inherited;
end;

procedure TIndicadorDPR.SetDescricao(const Value: string);
begin
  FDescricao := Value;
  PanelDescricao.Caption := FDescricao;
end;

procedure TIndicadorDPR.SetEspessuraLinhaMarcador(const Value: Integer);
begin
  ShapeMarcador.Pen.Width := Value;
end;

procedure TIndicadorDPR.SetExibirValorAtual(const Value: Boolean);
begin
  FExibirValorAtual := Value;
  JvPanelTransparente2.Visible := FExibirValorAtual;
end;

function TIndicadorDPR.GetFontPainelDescricao: TFont;
begin
  Result := PanelDescricao.Font;
end;

function TIndicadorDPR.GetFontPainelValorAtual: TFont;
begin
  Result := JvPanelTransparente2.Font;
end;

function TIndicadorDPR.GetLarguraMarcador: Integer;
begin
  Result := ShapeMarcador.Width;
end;

procedure TIndicadorDPR.SetFontPainelDescricao(const Value: TFont);
begin
  PanelDescricao.Font := Value;
end;

procedure TIndicadorDPR.SetFontPainelValorAtual(const Value: TFont);
begin
  JvPanelTransparente2.Font := Value;
end;

procedure TIndicadorDPR.SetGradient(const Value: Boolean);
begin
  FGradient := Value;
  AjustarCores;
  RefreshCorrecao;
end;

procedure TIndicadorDPR.SetLarguraMarcador(const Value: Integer);
begin
  ShapeMarcador.Width := Value;
  AjustarPosicionamento;
end;

procedure TIndicadorDPR.SetValorMinimo(const Value: Currency);
begin
  if (Value <> FValorMinimo) then
    begin
      if (Value > FValorMaximo)             then FValorMaximo             := Value;
      if (Value > FValorLimiteSuperiorMeio) then FValorLimiteSuperiorMeio := Value;
      if (Value > FValorAtual)              then FValorAtual              := Value;
      if (Value > FValorLimiteInferiorMeio) then FValorLimiteInferiorMeio := Value;

      FValorMinimo := Value;        

      AjustarPosicionamento;
      AjustarMeio;
    end;
end;

procedure TIndicadorDPR.SetValorAtual(const Value: Currency);
begin
  if (Value <> FValorAtual) then
    begin
      if (Value < FValorMinimo) then FValorMinimo := Value;
      if (Value > FValorMaximo) then FValorMaximo := Value;

      FValorAtual := Value;

      AtualizarExibicaoValorAtual;

      AjustarPosicionamento;
    end;
end;

procedure TIndicadorDPR.SetValorLimiteInferiorMeio(const Value: Currency);
begin
  if (Value <> FValorLimiteInferiorMeio) then
    begin
      if (Value < FValorMinimo)             then FValorMinimo             := Value;
      if (Value > FValorMaximo)             then FValorMaximo             := Value;
      if (Value > FValorLimiteSuperiorMeio) then FValorLimiteSuperiorMeio := Value;

      FValorLimiteInferiorMeio := Value;

      AjustarMeio;
    end;
end;

procedure TIndicadorDPR.SetValorLimiteSuperiorMeio(const Value: Currency);
begin
  if (Value <> FValorLimiteSuperiorMeio) then
    begin
      if (Value < FValorMinimo)             then FValorMinimo             := Value;
      if (Value > FValorMaximo)             then FValorMaximo             := Value;
      if (Value < FValorLimiteInferiorMeio) then FValorLimiteInferiorMeio := Value;

      FValorLimiteSuperiorMeio := Value;

      AjustarMeio;
    end;
end;

procedure TIndicadorDPR.SetValorMaximo(const Value: Currency);
begin
  if (Value <> FValorMaximo) then
    begin
      if (Value < FValorMinimo)             then FValorMinimo             := Value;
      if (Value < FValorLimiteInferiorMeio) then FValorLimiteInferiorMeio := Value;
      if (Value < FValorAtual)              then FValorAtual              := Value;
      if (Value < FValorLimiteSuperiorMeio) then FValorLimiteSuperiorMeio := Value;

      FValorMaximo := Value;

      AjustarPosicionamento;
      AjustarMeio;
    end;
end;

procedure TIndicadorDPR.SetAlturaPainelDescricao(const Value: Integer);
begin
  PanelDescricao.Height := Value;
  AtualizarHeightPanelTransparente;
  AtualizarHeightPanelTransparente2;
end;

procedure TIndicadorDPR.SetAutor(const Value: string);
begin
  if Value <> FAutor then
    Application.MessageBox(PChar(Contato), 'Contato', mb_Ok);
end;

procedure TIndicadorDPR.SetCorDireita(const Value: TColor);
begin
  FCorDireita := Value;
  AjustarCores;
  RefreshCorrecao;
end;

procedure TIndicadorDPR.SetCorMeio(const Value: TColor);
begin
  FCorMeio := Value;
  AjustarCores;
  RefreshCorrecao;
end;

procedure TIndicadorDPR.SetCorEsquerda(const Value: TColor);
begin
  FCorEsquerda := Value;
  AjustarCores;
  RefreshCorrecao;  
end;

function TIndicadorDPR.GetAlturaPainelDescricao: Integer;
begin
  Result := PanelDescricao.Height;
end;

function TIndicadorDPR.GetEspessuraLinhaMarcador: Integer;
begin
  Result := ShapeMarcador.Pen.Width;
end;

procedure TIndicadorDPR.AtualizarHeightPanelTransparente;
begin
  JvPanelTransparente.Height := (Height - PanelDescricao.Height) - 1;
end;

procedure TIndicadorDPR.AtualizarHeightPanelTransparente2;
begin
  JvPanelTransparente2.Height := JvPanelTransparente.Height;
end;

procedure TIndicadorDPR.AtualizarExibicaoValorAtual;
begin
  JvPanelTransparente2.Caption := CurrToStr(FValorAtual);
end;

procedure TIndicadorDPR.RefreshCorrecao;
begin
  // Ocorria um problema de não pintar o shape sobre o panel transparente
  JvPanelTransparente.Transparent := False;
  JvPanelTransparente.Transparent := True;

  JvPanelTransparente2.Transparent := False;
  JvPanelTransparente2.Transparent := True;
end;

procedure TIndicadorDPR.Resize;
begin
  inherited;

  JvPanelTransparente.Width  := Self.Width;
  JvPanelTransparente2.Width := Self.Width;

  AjustarMeio;
  AjustarPosicionamento;
  RefreshCorrecao;  
end;

procedure TIndicadorDPR.AjustarCores;
begin
  JvGradientEsquerdo.StartColor := FCorEsquerda;
  JvGradientCentro.StartColor   := FCorMeio;
  JvGradientCentro.EndColor     := FCorMeio;
  JvGradientDireito.EndColor    := FCorDireita;

  if FGradient then
    begin
      JvGradientEsquerdo.EndColor  := FCorMeio;
      JvGradientDireito.StartColor := FCorMeio;
    end
  else
    begin
      JvGradientEsquerdo.EndColor  := FCorEsquerda;
      JvGradientDireito.StartColor := FCorDireita;
    end;
end;

procedure TIndicadorDPR.AjustarMeio;
var
  TamanhoIntervalo: Currency;
  RepresentatividadeEsquerda: Currency;
  RepresentatividadeDireita: Currency;
begin
  TamanhoIntervalo := (FValorMaximo - FValorMinimo);

  RepresentatividadeEsquerda := ((FValorLimiteInferiorMeio - FValorMinimo) / TamanhoIntervalo);
  RepresentatividadeDireita  := ((FValorMaximo - FValorLimiteSuperiorMeio) / TamanhoIntervalo);

  JvGradientCentro.Align   := alNone;
  JvGradientEsquerdo.Width := Trunc(RepresentatividadeEsquerda * PanelDescricao.Width);
  JvGradientDireito.Width  := Trunc(RepresentatividadeDireita  * PanelDescricao.Width);
  JvGradientCentro.Align   := alClient;
end;

procedure TIndicadorDPR.AjustarPosicionamento;
const Margem = 2;
var
  TamanhoIntervalo: Currency;
  ProporcaoPreenchimento: Currency;
  EspacoDisponivel: Integer;
begin
  TamanhoIntervalo       := (FValorMaximo - FValorMinimo);
  ProporcaoPreenchimento := ((FValorAtual - FValorMinimo)/ TamanhoIntervalo);

  EspacoDisponivel       := (PanelDescricao.Width - ShapeMarcador.Width - (2 * Margem));
  ShapeMarcador.Left     := Margem + Round(EspacoDisponivel * ProporcaoPreenchimento);
  ShapeMarcador.Height   := (Height - PanelDescricao.Height) - 4;  
end;

procedure TIndicadorDPR.Imagem(out BMP: TBitMap);
begin
  if not Assigned(BMP) then Exit; // Evitar Violação de Acesso

  BMP.Width  := Self.Width;
  BMP.Height := Self.Height;
  BMP.Canvas.Brush := Self.Brush;
  BMP.Canvas.FillRect(Self.ClientRect);
  BMP.Canvas.Lock;
  try
    Self. PaintTo(BMP.Canvas.Handle, 0, 0);
  finally
    BMP.Canvas.Unlock;
  end;
end;
{$endregion}

initialization
  Contato := 'Autor: ' + C_Autor + #13 + 'E-mail: denisuba@gmail.com';

end.
