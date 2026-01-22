pageextension 50018 "Approval EntriesExt" extends "Approval Entries"
{
    layout
    {

    }

    actions
    {

    }
    trigger OnOpenPage()
    begin
        // MarkAllWhereUserisApproverOrSender;
    end;

    var
        Overdue: Option Yes," ";
        RecordIDText: Text;
        ShowChangeFactBox: Boolean;
        DelegateEnable: Boolean;
        ShowRecCommentsEnabled: Boolean;

    procedure Setfilterz(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentNo: Code[20])


    var
        Filterstring: Text;
        Usersetup: Record "User Setup";
    begin
        IF Usersetup.GET(USERID) THEN BEGIN
            Rec.FILTERGROUP(2);
            Filterstring := Rec.GETFILTERS;
            Rec.FILTERGROUP(0);
            IF STRLEN(Filterstring) = 0 THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETCURRENTKEY("Approver ID");
                IF Overdue = Overdue::Yes THEN
                    Rec.SETRANGE("Approver ID", Usersetup."User ID");
                Rec.SETRANGE(Status, Rec.Status::Open);
                Rec.FILTERGROUP(0);
            END ELSE
                Rec.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
        END;
    end;
}
