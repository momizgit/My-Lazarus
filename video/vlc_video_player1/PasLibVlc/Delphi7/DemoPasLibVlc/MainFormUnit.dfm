object MainForm: TMainForm
  Left = 411
  Top = 197
  Width = 640
  Height = 499
  Caption = 'libvlc demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OpenDialog: TOpenDialog
    DefaultExt = '*.*'
    Filter = 'All files|*.*'
    Title = 'Select file to play'
    Left = 8
    Top = 12
  end
  object MainMenu: TMainMenu
    Left = 44
    Top = 12
    object MenuFile: TMenuItem
      Caption = 'File'
      object MenuFileOpen: TMenuItem
        Caption = 'Open'
        ShortCut = 16463
        OnClick = MenuFileOpenClick
      end
      object MenuFileQuit: TMenuItem
        Caption = 'Quit'
        ShortCut = 16465
        OnClick = MenuFileQuitClick
      end
    end
  end
end
