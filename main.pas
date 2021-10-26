unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Spin;

type

  { TForm1 }

  TForm1 = class(TForm)
    ApplicationProperties1: TApplicationProperties;
    Button1h: TButton;
    Button30: TButton;
    Button2h: TButton;
    Button10: TButton;
    startBtn: TButton;
    mainLabel: TLabel;
    HourEdit: TSpinEdit;
    MinuteEdit: TSpinEdit;
    MinTimer: TTimer;
    hideBtn: TButton;
    WarnEdit: TSpinEdit;
    MainTimer: TTimer;
    procedure ApplicationProperties1Deactivate(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button1hClick(Sender: TObject);
    procedure Button2hClick(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure hideBtnClick(Sender: TObject);
    procedure MinTimerTimer(Sender: TObject);
    procedure startBtnClick(Sender: TObject);
    procedure MainTimerTimer(Sender: TObject);
  private
    procedure startTimer;

  public
    procedure SetLabels;

  end;

var
  Form1: TForm1;
  FCounter: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.startBtnClick(Sender: TObject);
begin
  FCounter := HourEdit.Value*60 + MinuteEdit.Value;
  startTimer;
end;

procedure TForm1.Button30Click(Sender: TObject);
begin
  FCounter := 30;
  startTimer;
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin

end;

procedure TForm1.FormWindowStateChange(Sender: TObject);
begin

end;

procedure TForm1.hideBtnClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TForm1.MinTimerTimer(Sender: TObject);
begin
  Application.Minimize;
  MinTimer.Enabled := false;
end;

procedure TForm1.Button2hClick(Sender: TObject);
begin
  FCounter := 120;
  startTimer;
end;

procedure TForm1.ApplicationProperties1Deactivate(Sender: TObject);
begin
  if MainTimer.Enabled and (FCounter > 0) then
     MinTimer.Enabled := True;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  FCounter := 10;
  startTimer;
end;

procedure TForm1.Button1hClick(Sender: TObject);
begin
  FCounter := 60;
  startTimer;
end;

procedure TForm1.MainTimerTimer(Sender: TObject);
begin
  Dec(FCounter);
  SetLabels;

  if (FCounter = WarnEdit.Value) or (FCounter <= 0) then
  begin
     Self.ShowOnTop;
     hideBtn.SetFocus;
  end;

  if (FCounter > 0) then
     MinTimer.Enabled := True;
end;

procedure TForm1.startTimer;
begin
  SetLabels;
  MainTimer.Enabled:=true;
  MinTimer.Enabled := True;
end;

procedure TForm1.SetLabels;
begin
  if FCounter < 0 then
    mainLabel.Font.Color := clRed
  else
    mainLabel.Font.Color := clDefault;

  mainLabel.Caption := IntToStr(FCounter) + ' min';
  Self.Caption := mainLabel.Caption;
  Application.Title:=mainLabel.Caption;
end;

end.

