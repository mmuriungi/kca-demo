page 52077 "HRM-Certifications"
{
    ApplicationArea = All;
    Caption = 'HRM-Certifications';
    PageType = List;
    SourceTable = "HRM-Certifications";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Body; Rec.Body)
                {
                    ToolTip = 'Specifies the value of the Body field.', Comment = '%';
                }
                field(Year; Rec.Year)
                {
                    ToolTip = 'Specifies the value of the Year field.', Comment = '%';
                }
                field(Qualification; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Qualification field.', Comment = '%';
                }
            }
        }
    }
}
