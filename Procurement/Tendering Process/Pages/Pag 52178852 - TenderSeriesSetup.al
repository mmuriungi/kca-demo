page 52178852 "Tender Series Setup"
{
    PageType = List;
    SourceTable = "Tender Series Setup";
    layout
    {
        area(content)
        {
            repeater(general)
            {

                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field.';
                }
                field("Tender Submission No."; Rec."Tender Submission No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Submission No. field.';
                }
            }
        }
    }
}