page 50048 "ACA-Hostel No Series"
{
    ApplicationArea = All;
    Caption = 'ACA-Hostel No Series';
    PageType = Card;
    SourceTable = "ACA-Hostel No Series";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Sub Store Nos"; Rec."Sub Store Nos")
                {
                    ToolTip = 'Specifies the value of the Sub Store Nos field.', Comment = '%';
                }
            }
        }
    }
}
