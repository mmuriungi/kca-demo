page 50216 "Operations Risk"
{
    Caption = 'Risk Category';
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /*field("Operations Risk"; DNotesText)
                {
                    Caption = 'Risk Category';

                    trigger OnValidate()
                    begin

                        CALCFIELDS(Description);
                        Description.CREATEINSTREAM(Instr);
                        DNotes.READ(Instr);

                        IF DNotesText <> FORMAT(DNotes) THEN BEGIN
                            CLEAR(Description);
                            CLEAR(DNotes);
                            DNotes.ADDTEXT(DNotesText);
                            Description.CREATEOUTSTREAM(OutStr);
                            DNotes.WRITE(OutStr);
                        END;
                    end;
                }*/

                field("Risk Category"; "Risk Category")
                {
                }
                field("Risk Category Description"; "Risk Category Description")
                {
                }
                field("Risk Likelihood"; "Risk Likelihood")
                {
                }
                field("Risk Rating"; Rating2)
                {
                    Caption = 'Rating';
                }
                field("Risk Impacts"; "Risk Impacts")
                {
                }
                field("Risk Mitigation"; "Risk Mitigation")
                {
                }
                field("Risk Opportunities"; "Risk Opportunities")
                {
                }
                field("Document No."; "Document No.")
                {
                    Enabled = false;
                }
                field("Line No."; "Line No.")
                {
                    Enabled = false;
                }
                field("Audit Line Type"; Rec."Audit Line Type")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin

        CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    trigger OnAfterGetRecord()
    begin

        CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
}

