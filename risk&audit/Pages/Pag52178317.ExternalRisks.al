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
                    ApplicationArea = All;
                    Caption = 'External Risks';

                    trigger OnValidate()
                    begin

                    end;
                }
                field("Risk Likelihood"; Rec."Risk Likelihood")
                {
                    ApplicationArea = All;
                }
                field("Risk Category"; Rec."Risk Category")
                {
                    ApplicationArea = All;
                }
                field("Risk Category Description"; Rec."Risk Category Description")
                {
                    ApplicationArea = All;
                }
                field("Risk Rating"; Rec.Rating2)
                {
                    ApplicationArea = All;
                    Caption = 'Rating';
                }
                field("Risk Impacts"; Rec."Risk Impacts")
                {
                    ApplicationArea = All;
                }
                field("Risk Mitigation"; Rec."Risk Mitigation")
                {
                    ApplicationArea = All;
                }
                field("Risk Opportunities"; Rec."Risk Opportunities")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
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

