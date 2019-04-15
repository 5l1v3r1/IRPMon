Unit FileObjectNameXXXRequest;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

Interface

Uses
  Windows,
  RequestListModel, IRPMonDll;

Type
  TFileObjectNameAssignedRequest = Class (TDriverRequest)
    Public
      Constructor Create(Var ARequest:REQUEST_FILE_OBJECT_NAME_ASSIGNED); Reintroduce;
      Function GetColumnValue(AColumnType:ERequestListModelColumnType; Var AResult:WideString):Boolean; Override;
    end;

  TFileObjectNameDeletedRequest = Class (TDriverRequest)
    Public
      Constructor Create(Var ARequest:REQUEST_FILE_OBJECT_NAME_DELETED); Reintroduce;
      Function GetColumnValue(AColumnType:ERequestListModelColumnType; Var AResult:WideString):Boolean; Override;
    end;



Implementation

Uses
  SysUtils;

(** TFileObjectNameAssignedRequest **)

Constructor TFileObjectNameAssignedRequest.Create(Var ARequest:REQUEST_FILE_OBJECT_NAME_ASSIGNED);
Var
  fn : PWideChar;
  tmpFileName : WideString;
begin
Inherited Create(ARequest.Header);
SetFileObject(ARequest.FileObject);
fn := PWideChar(PByte(@ARequest) + SizeOf(REQUEST_FILE_OBJECT_NAME_ASSIGNED));
SetLength(tmpFileName, ARequest.FileNameLength Div SizeOf(WideChar));
CopyMemory(PWideChar(tmpFileName), fn, ARequest.FileNameLength);
SetFileName(tmpFileName);
end;

Function TFileObjectNameAssignedRequest.GetColumnValue(AColumnType:ERequestListModelColumnType; Var AResult:WideString):Boolean;
begin
Result := True;
Case AColumnType Of
  rlmctDeviceObject,
  rlmctDeviceName,
  rlmctResult,
  rlmctDriverObject,
  rlmctDriverName : Result := False;
  Else Result := Inherited GetColumnValue(AColumnType, AResult);
  end;
end;


(** TFileObjectNameDeletedRequest **)

Constructor TFileObjectNameDeletedRequest.Create(Var ARequest:REQUEST_FILE_OBJECT_NAME_DELETED);
begin
Inherited Create(ARequest.Header);
SetFileObject(ARequest.FileObject);
end;

Function TFileObjectNameDeletedRequest.GetColumnValue(AColumnType:ERequestListModelColumnType; Var AResult:WideString):Boolean;
begin
Result := True;
Case AColumnType Of
  rlmctDeviceObject,
  rlmctDeviceName,
  rlmctResult,
  rlmctDriverObject,
  rlmctDriverName : Result := False;
  Else Result := Inherited GetColumnValue(AColumnType, AResult);
  end;
end;


End.
