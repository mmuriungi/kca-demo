page 50097 "Approved Risk List"
{
    Caption = 'Risk Manager List';
    CardPageID = "Risk Card";
    PageType = List;
    SourceTable = "Risk Header";
    DeleteAllowed = false;
    SourceTableView = WHERE("Document Status" = filter("Risk Manager"), Rejected = filter(false), "Consolidate to HQ" = filter(false));
    //  SourceTableView = WHERE(Status = filter(Released), Rejected = filter(false), "Plan Type" = const("Organizational Plan"));

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
                field("Station Name"; Rec."Station Name")
                {

                }
                field("Document Status"; Rec."Document Status")
                {

                }
                field("Risk Description2"; Rec."Risk Description2")
                {
                    Caption = 'Objective';
                }
                field("Risk Description"; Rec."Risk Description")
                {
                    MultiLine = true;
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

    trigger OnDeleteRecord(): Boolean
    begin
        Error('You Are Not Allowed To Delete A Record');
    end;

    var
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

