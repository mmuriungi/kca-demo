page 50057 "Auditee Reports"
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
                field("No."; "No.")
                {
                }
                field(Date; Date)
                {
                }
                field(Status; Status)
                {
                }
                field(Description; Description)
                {
                }
                field(Auditee; Auditee)
                {
                }
                field("Auditee User ID"; "Auditee User ID")
                {
                }
                field("Audit Period"; "Audit Period")
                {
                }
                field("Department Name"; "Department Name")
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
        Type := Type::"Audit Report";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Audit Report";
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

