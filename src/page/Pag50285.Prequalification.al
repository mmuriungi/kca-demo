page 50285 Prequalification
{
    Caption = 'Prequalification';
    PageType = Card;
    SourceTable = "Preq Categories/Years";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Preq Category"; Rec."Preq Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Category field.';
                    TableRelation = "Prequalification Categories";
                }
                field("Preq Year"; Rec."Preq Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Year field.';
                    TableRelation = "Prequalification Years";
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Prequalified Supliers"; Rec."Prequalified Supliers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalified Supliers field.';
                }
            }
            part(preqSup; "Prequalified Supliers")
            {
                ApplicationArea = all;
                SubPageLink = "Preq Year" = field("Preq Year"), "Preq Category" = field("Preq Category");

            }
        }
    }
}
