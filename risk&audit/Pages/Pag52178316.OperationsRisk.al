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

                field("Risk Category"; Rec."Risk Category")
                {
                }
                field("Risk Category Description"; Rec."Risk Category Description")
                {
                }
                field("Risk Likelihood"; Rec."Risk Likelihood")
                {
                }
                field("Risk Rating"; Rec.Rating2)
                {
                    Caption = 'Rating';
                }
                field("Risk Impacts"; Rec."Risk Impacts")
                {
                }
                field("Risk Mitigation"; Rec."Risk Mitigation")
                {
                }
                field("Risk Opportunities"; Rec."Risk Opportunities")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                    Enabled = false;
                }
                field("Line No."; Rec."Line No.")
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


    end;

    trigger OnAfterGetRecord()
    begin


    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
}

