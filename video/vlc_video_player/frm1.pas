unit frm1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, PasLibVlcPlayerUnit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnOpen: TBitBtn;
    btnOpenURL: TBitBtn;
    btnPlay: TBitBtn;
    btnPause: TBitBtn;
    Label1: TLabel;
    lblTime: TLabel;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    vlcPlayer: TPasLibVlcPlayer;
    trkPosition: TTrackBar;
    trkVolume: TTrackBar;
    procedure btnOpenClick(Sender: TObject);
    procedure btnOpenURLClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure trkPositionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure trkPositionMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure trkVolumeChange(Sender: TObject);
    procedure vlcPlayerMediaPlayerLengthChanged(Sender: TObject; time: Int64);
    procedure vlcPlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnOpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    vlcPlayer.Play(WideString(OpenDialog1.FileName));
    Caption := OpenDialog1.FileName;
  end;
end;

procedure TForm1.btnOpenURLClick(Sender: TObject);
var
  url: string;
begin
  url := InputBox('Media URL', 'Please enter media URL/MRL', '');
  if url <> '' then begin
    vlcPlayer.Play(WideString(url));
    Caption := url;
  end;
end;

procedure TForm1.btnPauseClick(Sender: TObject);
begin
  vlcPlayer.Pause();
end;

procedure TForm1.btnPlayClick(Sender: TObject);
begin
  vlcPlayer.Resume();
end;

procedure TForm1.trkPositionMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  trkPosition.Tag := 1;
end;

procedure TForm1.trkPositionMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  vlcPlayer.SetVideoPosInMs(trkPosition.Position);
  trkPosition.Tag := 0;
end;

procedure TForm1.trkVolumeChange(Sender: TObject);
begin
  vlcPlayer.SetAudioVolume(trkVolume.Position);
end;

procedure TForm1.vlcPlayerMediaPlayerLengthChanged(Sender: TObject; time: Int64
  );
begin
  trkPosition.Max := vlcPlayer.GetVideoLenInMs();
end;

procedure TForm1.vlcPlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
begin
  if trkPosition.Tag = 0 then // not dragging with mouse
    trkPosition.Position := vlcPlayer.GetVideoPosInMs();
  lblTime.Caption:=vlcPlayer.GetVideoPosStr('hh:mm:ss');
end;

end.

