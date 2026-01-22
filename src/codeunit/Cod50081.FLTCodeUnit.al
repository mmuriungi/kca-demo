codeunit 50081 "FLT- Code Unit"
{
    var
        transRe: Record "FLT-Transport Requisition";
        transR: Record "FLT-Transport Requisition";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";


    procedure createCarPool(No: code[20])
    begin

        FltMgtSetup.Get;
        FltMgtSetup.TestField(FltMgtSetup."Transport Req No");

        transRe.Reset();
        transRe.SetRange("Transport Requisition No", No);
        if transRe.Find('-') then begin
            transR.Init();
            transR."Transport Requisition No" := NoSeriesMgt.GetNextNo(FltMgtSetup."Transport Req No", 0D, TRUE);
            transR."Date of Request" := Today();
            transR."Department Code" := transRe."Department Code";
            transR."Duration to be Away" := transRe."Duration to be Away";
            transR.Destination := transRe.Destination;
            transR."Requested By" := UserId;
            transR."Number of Passangers" := transRe."Number of Passangers";
            transR.Status := transR.Status::"Pending Approval";
            transR."Approval Stage" := transRe."Approval Stage"::"Transport Officer";
            transR."Date of Trip" := transRe."Date of Trip";
            transR.Insert();
        end;
        //Date of Request" := Today();
        //"Requested By" := UserId;

    end;
}
