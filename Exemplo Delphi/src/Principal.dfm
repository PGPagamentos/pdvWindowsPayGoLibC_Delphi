object TelPrincipal: TTelPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste de Integra'#231#227'o PGWebLib'
  ClientHeight = 556
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 327
    Top = 180
    Width = 37
    Height = 16
    Caption = 'Label1'
    Visible = False
  end
  object Panel1: TPanel
    Left = 11
    Top = 394
    Width = 601
    Height = 97
    TabOrder = 0
    object Label2: TLabel
      Left = 48
      Top = 10
      Width = 140
      Height = 16
      Caption = 'PWINFO_AUTNAME(21):'
    end
    object Label3: TLabel
      Left = 48
      Top = 30
      Width = 130
      Height = 16
      Caption = 'PWINFO_AUTVER(22):'
    end
    object Label4: TLabel
      Left = 48
      Top = 52
      Width = 130
      Height = 16
      Caption = 'PWINFO_AUTDEV(23):'
    end
    object Label5: TLabel
      Left = 48
      Top = 73
      Width = 130
      Height = 16
      Caption = 'PWINFO_AUTCAP(36):'
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 18
    Width = 409
    Height = 367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    Visible = False
  end
  object Button1: TButton
    Left = 14
    Top = 510
    Width = 118
    Height = 39
    Caption = 'Limpar Log'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 264
    Top = 509
    Width = 169
    Height = 41
    Caption = 'Capturar Dados no PinPad'
    TabOrder = 3
    OnClick = Button2Click
  end
  object MainMenu1: TMainMenu
    Left = 608
    Top = 16
    object Operaes1: TMenuItem
      Caption = 'Menu - Op'#231#245'es'
      object PWiInit1: TMenuItem
        Caption = '1 - PW_iInit - Inicializar'
        OnClick = PWiInit1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object PWiNewTransac1: TMenuItem
        Caption = '2 - PW_iNewTransac'
        object PWOPERINSTALL1: TMenuItem
          Caption = '1 - PWOPER_INSTALL - Instala'#231#227'o'
          OnClick = PWOPERINSTALL1Click
        end
        object N3: TMenuItem
          Caption = '-'
        end
        object PWOPERSALEVenda1: TMenuItem
          Caption = '2  - PWOPER_SALE      - Venda'
          OnClick = PWOPERSALEVenda1Click
        end
        object N4: TMenuItem
          Caption = '-'
        end
        object PWOPERSALEVOIDCancelamento1: TMenuItem
          Caption = '3 - PWOPER_SALEVOID - Cancelamento'
          OnClick = PWOPERSALEVOIDCancelamento1Click
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object PWOPERVERSIONVersodaDLL1: TMenuItem
          Caption = '4  - PWOPER_VERSION - Vers'#227'o da DLL'
          OnClick = PWOPERVERSIONVersodaDLL1Click
        end
        object N6: TMenuItem
          Caption = '-'
        end
        object N5PWOPERREPRINTReimpresso1: TMenuItem
          Caption = '5 - PWOPER_REPRINT  - Reimpress'#227'o'
          OnClick = N5PWOPERREPRINTReimpresso1Click
        end
        object N7: TMenuItem
          Caption = '-'
        end
        object PWOPERRPTDETAIL1: TMenuItem
          Caption = '6 - PWOPER_RPTDETAIL - Relat'#243'rios'
          OnClick = PWOPERRPTDETAIL1Click
        end
        object N8: TMenuItem
          Caption = '-'
        end
        object N7PWOPERADMIN1: TMenuItem
          Caption = '7 - PWOPER_ADMIN       - Administrativo'
          OnClick = N7PWOPERADMIN1Click
        end
        object N10: TMenuItem
          Caption = '-'
        end
        object N8TestaAutoAtendimento1: TMenuItem
          Caption = '8 -  Auto Atendimento'
          OnClick = N8TestaAutoAtendimento1Click
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object PWiConfirmation1: TMenuItem
        Caption = '3 - PW_iConfirmation - Confirma'#231#227'o'
        OnClick = PWiConfirmation1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
    end
  end
  object ActionList1: TActionList
    Left = 600
    Top = 128
    object Abortar: TAction
      Caption = 'Abortar'
      ShortCut = 32795
      OnExecute = AbortarExecute
    end
  end
end
