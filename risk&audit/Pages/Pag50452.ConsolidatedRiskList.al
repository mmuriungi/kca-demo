page 50099 "Consolidated Risk List"
{
    CardPageID = "Consolidated Risk Card";
    PageType = List;
    // Caption = 'Rejected Risks List';
    SourceTable = "Risk Header";
    DeleteAllowed = false;
    //SourceTableView = where(Status = filter(New | "Pending Approval" | Released));
    SourceTableView = where("Plan Type" = const("Organizational Plan"), Status = filter(New | "Pending Approval" | Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Audit Period"; Rec."Audit Period")
                {
                    ApplicationArea = All;

                }
                // field("Risk Description2"; "Risk Description2")
                // {
                //     Caption = 'Objective';
                // }
                // field("Employee No."; "Employee No.")
                // {
                // }
                // field("Employee Name"; "Employee Name")
                // {
                // }
                field("Current Plan"; Rec."Current Plan")
                {
                    ApplicationArea = All;

                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;

                }
                field("Risk Description"; Rec."Risk Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin

                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Risk Description");
    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup."Risk Admin" THEN
              BEGIN
                FILTERGROUP(2);
                SETRANGE("Created By",USERID);
              END;
          END ELSE
            ERROR('The User %1 does not exist in the User Setup',USERID);
        */

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('You Are Not Allowed To Delete A Record');
    end;

    var
        UserSetup: Record "User Setup";
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

