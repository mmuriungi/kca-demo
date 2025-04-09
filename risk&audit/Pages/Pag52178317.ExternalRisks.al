page 50217 "External Risks"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("External Risks"; Rec.Description)
                {
                    Caption = 'External Risks';

                    trigger OnValidate()
                    begin

                    end;
                }
                field("Risk Likelihood"; Rec."Risk Likelihood")
                {
                }
                field("Risk Category"; Rec."Risk Category")
                {
                }
                field("Risk Category Description"; Rec."Risk Category Description")
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

