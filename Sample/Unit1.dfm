object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo de uso dos Componentes DPR'
  ClientHeight = 504
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TreeViewDPR1: TTreeViewDPR
    Left = 0
    Top = 0
    Width = 233
    Height = 408
    Align = alLeft
    HotTrack = True
    Indent = 19
    ReadOnly = True
    TabOrder = 0
    Autor = 'Denis Pereira Raymundo'
    ExplicitHeight = 470
  end
  object IndicadorDPR1: TIndicadorDPR
    Left = 0
    Top = 470
    Width = 755
    Height = 34
    Autor = 'Denis Pereira Raymundo'
    Descricao = 'Valor de Alguma Coisa'
    ValorMaximo = 100.000000000000000000
    ValorAtual = 75.000000000000000000
    ValorLimiteInferiorMeio = 33.000000000000000000
    ValorLimiteSuperiorMeio = 66.000000000000000000
    FontPainelDescricao.Charset = DEFAULT_CHARSET
    FontPainelDescricao.Color = clWindowText
    FontPainelDescricao.Height = -11
    FontPainelDescricao.Name = 'Tahoma'
    FontPainelDescricao.Style = []
    FontPainelValorAtual.Charset = DEFAULT_CHARSET
    FontPainelValorAtual.Color = clWindowText
    FontPainelValorAtual.Height = -11
    FontPainelValorAtual.Name = 'Tahoma'
    FontPainelValorAtual.Style = []
    AlturaPainelDescricao = 18
    LarguraMarcador = 5
    EspessuraLinhaMarcador = 2
    ExibirValorAtual = False
    Gradient = True
    Align = alBottom
    ExplicitLeft = 167
    ExplicitTop = 184
    ExplicitWidth = 400
    DesignSize = (
      755
      34)
  end
  object DBGrid1: TDBGrid
    Left = 233
    Top = 0
    Width = 522
    Height = 408
    Align = alClient
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 755
    Height = 62
    Align = alBottom
    TabOrder = 3
    object ButtonExportarCSV: TButton
      Left = 504
      Top = 16
      Width = 105
      Height = 25
      Caption = 'Exportar para CSV'
      TabOrder = 0
      OnClick = ButtonExportarCSVClick
    end
    object ButtonExportarHTML: TButton
      Left = 615
      Top = 16
      Width = 114
      Height = 25
      Caption = 'Exportar para HTML'
      TabOrder = 1
      OnClick = ButtonExportarHTMLClick
    end
    object ButtonPesquisar: TButton
      Left = 393
      Top = 16
      Width = 105
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 2
      OnClick = ButtonPesquisarClick
    end
  end
  object GridParaHTML1: TGridParaHTML
    Autor = 'Denis Pereira Raymundo'
    Arquivo = '.HTM'
    Rodape = 'Informa'#231#245'es no Rodap'#233
    Titulo = 'Customers'
    Visualizar = False
    CorpoFontePadrao = False
    CabecalhoFontePadrao = False
    Left = 664
    Top = 368
  end
  object Pesquisa1: TPesquisa
    Autor = 'Denis Pereira Raymundo'
    Esquerda = 0
    Posicao = poScreenCenter
    TipoCaracter = tcNormal
    Topo = 0
    Left = 432
    Top = 368
  end
  object DataSetParaCSV1: TDataSetParaCSV
    Autor = 'Denis Pereira Raymundo'
    Delimitador = '"'
    DoInicio = True
    Extensao = '.CSV'
    Separador = ','
    MaximoRegistrosPorArquivo = 0
    Left = 536
    Top = 368
  end
  object MainMenu1: TMainMenu
    Left = 48
    Top = 8
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Caption = '&New'
        OnClick = New1Click
      end
      object Open1: TMenuItem
        Caption = '&Open...'
      end
      object Save1: TMenuItem
        Caption = '&Save'
      end
      object SaveAs1: TMenuItem
        Caption = 'Save &As...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Caption = '&Print...'
      end
      object PrintSetup1: TMenuItem
        Caption = 'P&rint Setup...'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object Undo1: TMenuItem
        Caption = '&Undo'
        ShortCut = 16474
      end
      object Repeat1: TMenuItem
        Caption = '&Repeat <command>'
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Cut1: TMenuItem
        Caption = 'Cu&t'
        ShortCut = 16472
      end
      object Copy1: TMenuItem
        Caption = '&Copy'
        ShortCut = 16451
      end
      object Paste1: TMenuItem
        Caption = '&Paste'
        ShortCut = 16470
      end
      object PasteSpecial1: TMenuItem
        Caption = 'Paste &Special...'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Find1: TMenuItem
        Caption = '&Find...'
      end
      object Replace1: TMenuItem
        Caption = 'R&eplace...'
      end
      object GoTo1: TMenuItem
        Caption = '&Go To...'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Links1: TMenuItem
        Caption = 'Lin&ks...'
      end
      object Object1: TMenuItem
        Caption = '&Object'
      end
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 272
    Top = 56
  end
end
