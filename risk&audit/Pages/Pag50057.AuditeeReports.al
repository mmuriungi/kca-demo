page 50264 "Auditee Reports"
{
    CardPageID = "Audit Report Card";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE(Type = FILTER("Audit Report"), "Report Status" = FILTER(Auditee));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Auditee; Rec.Auditee)
                {
                }
                field("Auditee User ID"; Rec."Auditee User ID")
                {
                }
                field("Audit Period"; Rec."Audit Period")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Report";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Report";
    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserSetup.GET(USERID) THEN
          BEGIN
            IF NOT UserSetup."Audit Admin" THEN
              BEGIN
                FILTERGROUP(2);
                SETRANGE("Auditee User ID",USERID);
              END;
          END ELSE
            ERROR(UserNotFoundErr,USERID);
        */

    end;

    var
        UserSetup: Record "User Setup";
        UserNotFoundErr: Label 'The User ID %1 does not exist in the User Setup';
}

