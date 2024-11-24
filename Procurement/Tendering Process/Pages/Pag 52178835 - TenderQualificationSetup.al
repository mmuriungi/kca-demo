page 52178835 "Tender Qualification Setup"
{
    PageType = List;
    SourceTable = "Tender Qualification Setup";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Tender No."; Rec."Tender No.")
                {
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    ApplicationArea = All;
                }
                field("Technical Percentage"; Rec."Technical Percentage")
                {
                    ToolTip = 'Specifies the value of the Technical Percentage field.';
                    ApplicationArea = All;
                }
                field("Demo Percentage"; Rec."Demo Percentage")
                {
                    ToolTip = 'Specifies the value of the Demo Percentage field.';
                    ApplicationArea = All;
                }
                field("Financial Percentage"; Rec."Financial Percentage")
                {
                    ToolTip = 'Specifies the value of the Financial Percentage field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}