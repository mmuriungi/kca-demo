page 50226 "Risk List Pending Approval"
{
    Caption = 'Risk Owner List';
    CardPageID = "Risk Card";
    PageType = List;
    SourceTable = "Risk Header";
    DeleteAllowed = false;
    SourceTableView = WHERE("Document Status" = filter("Risk Owner"), Rejected = filter(false));
    // SourceTableView = WHERE(Status = filter("Pending Approval"), Rejected = filter(false), "Plan Type" = const("Organizational Plan"));


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
                field("Risk Description"; RiskNotesText)
                {
                    MultiLine = true;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Risk Description");
                        "Risk Description".CREATEINSTREAM(Instr);
                        RiskNote.READ(Instr);

                        IF RiskNotesText <> FORMAT(RiskNote) THEN BEGIN
                            CLEAR(Rec."Risk Description");
                            CLEAR(RiskNote);
                            RiskNote.ADDTEXT(RiskNotesText);
                            "Risk Description".CREATEOUTSTREAM(OutStr);
                            RiskNote.WRITE(OutStr);
                        END;
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
        "Risk Description".CREATEINSTREAM(Instr);
        RiskNote.READ(Instr);
        RiskNotesText := FORMAT(RiskNote);
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

