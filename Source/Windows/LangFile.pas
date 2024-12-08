unit LangFile;

interface

uses
  Classes, SysUtils, Generics.Collections;

type
  TLangFile = class
  private
    FCache: TDictionary<string, string>;
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    function GetString(const Key, DefaultValue: string): string;
  end;

implementation

constructor TLangFile.Create(const FileName: string);
var
  LangFile: TStringList;
  i, PosEqual: Integer;
  Key, Value: string;
begin
  FCache := TDictionary<string, string>.Create;
  LangFile := TStringList.Create;
  if not FileExists(FileName) then Exit;
  try
    LangFile.LoadFromFile(FileName, TEncoding.UTF8);
    for i := 0 to LangFile.Count - 1 do
    begin
      PosEqual := Pos('=', LangFile[i]);
      if PosEqual <> 0 then
      begin
        Key := Trim(Copy(LangFile[i], 1, PosEqual - 1));
        Value := Trim(Copy(LangFile[i], PosEqual + 1, MaxInt));
        FCache.Add(Key, Value);
      end;
    end;
  finally
    LangFile.Free;
  end;
end;

destructor TLangFile.Destroy;
begin
  FCache.Free;
  inherited;
end;

function TLangFile.GetString(const Key, DefaultValue: string): string;
begin
  if not FCache.TryGetValue(Key, Result) then
    Result := DefaultValue;
end;

end.

