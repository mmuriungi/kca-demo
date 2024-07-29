page 55119 "REG-Outward Register B"
{
    Caption = 'REG-Outward Register B';
    PageType = Card;
    SourceTable = "Outward Register B";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                    ApplicationArea = All;
                }
                field("From File Index"; Rec."From File Index")
                {
                    ToolTip = 'Specifies the value of the From File Index field.';
                    ApplicationArea = All;
                }
                field("From File Name"; Rec."From File Name")
                {
                    ToolTip = 'Specifies the value of the From File Name field.';
                    ApplicationArea = All;
                }
                field("To Who"; Rec."To Who")
                {
                    ToolTip = 'Specifies the value of the To Who field.';
                    ApplicationArea = All;
                }
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.';
                    ApplicationArea = All;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ToolTip = 'Specifies the value of the Date Sent field.';
                    ApplicationArea = All;
                }
                field(Region; Rec.Region)
                {
                    ToolTip = 'Specifies the value of the Region field.';
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
