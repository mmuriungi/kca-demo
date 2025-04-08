page 50450 "Approved Risk List"
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
                field("No."; "No.")
                {
                }
                field("Date Created"; "Date Created")
                {
                }
                field("Created By"; "Created By")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field("Station Name"; "Station Name")
                {

                }
                field("Document Status"; "Document Status")
                {

                }
                field("Risk Description2"; "Risk Description2")
                {
                    Caption = 'Objective';
                }
                field("Risk Description"; RiskNotesText)
                {
                    MultiLine = true;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CALCFIELDS("Risk Description");
                        "Risk Description".CREATEINSTREAM(Instr);
                        RiskNote.READ(Instr);

                        IF RiskNotesText <> FORMAT(RiskNote) THEN BEGIN
                            CLEAR("Risk Description");
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

        CALCFIELDS("Risk Description");
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

