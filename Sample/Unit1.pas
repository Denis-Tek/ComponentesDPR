unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, ComponentesDPR, ShellApi,
  Vcl.ComCtrls, Vcl.Menus, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient;

type
  TForm1 = class(TForm)
    TreeViewDPR1: TTreeViewDPR;
    GridParaHTML1: TGridParaHTML;
    Pesquisa1: TPesquisa;
    DataSetParaCSV1: TDataSetParaCSV;
    IndicadorDPR1: TIndicadorDPR;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    Print1: TMenuItem;
    PrintSetup1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Repeat1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    PasteSpecial1: TMenuItem;
    Find1: TMenuItem;
    Replace1: TMenuItem;
    GoTo1: TMenuItem;
    Links1: TMenuItem;
    Object1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    ClientDataSet1: TClientDataSet;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    ButtonExportarCSV: TButton;
    ButtonExportarHTML: TButton;
    ButtonPesquisar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonPesquisarClick(Sender: TObject);
    procedure ButtonExportarCSVClick(Sender: TObject);
    procedure ButtonExportarHTMLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  TreeViewDPR1.MenuPrincipal := MainMenu1;
  TreeViewDPR1.Preenche;

  Pesquisa1.DataSet := ClientDataSet1;
  Pesquisa1.Campo   := 'Company';
  Pesquisa1.Titulo  := 'Pesquisar pelo nome da companhia';

  DataSetParaCSV1.DataSet := ClientDataSet1;
  DataSetParaCSV1.ArquivoBase := ExtractFilePath(ParamStr(0)) + 'Customer.csv';

  GridParaHTML1.DBGrid := DBGrid1;
  GridParaHTML1.Arquivo := ExtractFilePath(ParamStr(0)) + 'Customer.htm';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ClientDataSet1.LoadFromFile('C:\Users\Public\Documents\Embarcadero\Studio\21.0\Samples\Data\customer.cds');
  ClientDataSet1.IndexFieldNames := 'Company';
end;

procedure TForm1.ButtonPesquisarClick(Sender: TObject);
begin
  if Pesquisa1.Pesquisar then
    ShowMessage('Confirmou a pesquisa');
end;

procedure TForm1.ButtonExportarCSVClick(Sender: TObject);
begin
  if DataSetParaCSV1.Executar then
    ShowMessage('Salvou o arquivo na pasta do executável');
end;

procedure TForm1.ButtonExportarHTMLClick(Sender: TObject);
begin
  if GridParaHTML1.Executar then
    ShellExecute(0, 'open', PWideChar('file://' + GridParaHTML1.Arquivo), nil, nil, 0);
end;

procedure TForm1.New1Click(Sender: TObject);
begin
  ShowMessage('Clicou no new file');
end;

end.
