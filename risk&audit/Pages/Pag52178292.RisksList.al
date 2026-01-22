page 50188 "Risks List"
{

    CardPageID = "Risk Card";
    PageType = List;
    SourceTable = "Risk Header";
    DeleteAllowed = false;
    SourceTableView = WHERE("Document Status" = FILTER(New));
    //SourceTableView = WHERE("Document Status" = FILTER(New), Status = filter(New), "Plan Type" = const("Department Plan"));

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
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Audit Period"; Rec."Audit Period")
                {
                    ApplicationArea = All;
                    Caption = 'Risk Period';
                }


                field("Risk Description2"; Rec."Risk Description2")
                {
                    ApplicationArea = All;
                    Caption = 'Objective';
                }
                field("Station Code"; Rec."Station Code")
                {
                    ApplicationArea = All;

                }
                field("Station Name"; Rec."Station Name")
                {
                    ApplicationArea = All;

                }
                field("Document Status"; Rec."Document Status")
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
        //  Error('You Are Not Allowed To Delete A Record');
    end;

    var
        UserSetup: Record "User Setup";
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

