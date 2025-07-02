page 50188 "Risks List"
{

    CardPageID = "Risk Card";
    PageType = List;
    Caption = 'Risk Champion';
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
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Audit Period"; Rec."Audit Period")
                {
                    Caption = 'Risk Period';
                }


                field("Risk Description2"; Rec."Risk Description2")
                {
                    Caption = 'Objective';
                }
                field("Station Code"; Rec."Station Code")
                {

                }
                field("Station Name"; Rec."Station Name")
                {

                }
                field("Document Status"; Rec."Document Status")
                {

                }
                field("Risk Description"; Rec."Risk Description")
                {
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

