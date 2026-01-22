page 50093 "Koha Setup"
{
    ApplicationArea = All;
    Caption = 'Koha Setup';
    PageType = Card;
    SourceTable = "Koha Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Base Url"; Rec."Base Url")
                {
                    ToolTip = 'Specifies the value of the Base Url field.', Comment = '%';
                }
                field(Username; Rec.Username)
                {
                    ToolTip = 'Specifies the value of the Username field.', Comment = '%';
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.', Comment = '%';
                    HideValue = true;
                }
                field("Auto Push Records"; Rec."Auto Push Records")
                {
                    ToolTip = 'Specifies the value of the Auto Push Records field.', Comment = '%';
                }
            }
        }
    }
}
