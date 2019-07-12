object TelCaptura: TTelCaptura
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Captura  No Pinpad'
  ClientHeight = 223
  ClientWidth = 531
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 39
    Width = 51
    Height = 13
    Caption = 'Mensagem'
  end
  object Label2: TLabel
    Left = 336
    Top = 39
    Width = 32
    Height = 13
    Caption = 'Minimo'
  end
  object Label3: TLabel
    Left = 424
    Top = 40
    Width = 36
    Height = 13
    Caption = 'Maximo'
  end
  object Label4: TLabel
    Left = 58
    Top = 115
    Width = 31
    Height = 13
    Caption = 'Label4'
    Visible = False
  end
  object ComboBox3: TComboBox
    Left = 409
    Top = 55
    Width = 80
    Height = 21
    TabOrder = 0
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12')
  end
  object ComboBox2: TComboBox
    Left = 318
    Top = 55
    Width = 80
    Height = 21
    TabOrder = 1
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12')
  end
  object ComboBox1: TComboBox
    Left = 23
    Top = 55
    Width = 271
    Height = 21
    TabOrder = 2
    Items.Strings = (
      'DIGITE_O_DDD'
      'REDIGITE_O_DDD'
      'DIGITE_O_TELEFONE'
      'REDIGITE_O_TELEFONE'
      'DIGITE_DDD_TELEFONE'
      'REDIGITE_DDD_TELEFONE'
      'DIGITE_O_CPF'
      'REDIGITE_O_CPF'
      'DIGITE_O_RG'
      'REDIGITE_O_RG'
      'DIGITE_OS_4_ULTIMOS_DIGITOS'
      'DIGITE_CODIGO_DE_SEGURANCA')
  end
  object Button1: TButton
    Left = 24
    Top = 177
    Width = 101
    Height = 39
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 360
    Top = 176
    Width = 111
    Height = 39
    Caption = 'Aplicar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object RadioButton1: TRadioButton
    Left = 107
    Top = 8
    Width = 113
    Height = 17
    Caption = 'PW_iPPGetUserData'
    Checked = True
    TabOrder = 5
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 268
    Top = 8
    Width = 113
    Height = 17
    Caption = 'PW_iPPGetPINBlock'
    TabOrder = 6
    OnClick = RadioButton2Click
  end
end
