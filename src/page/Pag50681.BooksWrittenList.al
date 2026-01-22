page 50681 "Books Written List"
{
    Caption = 'Books Written List';
    PageType = List;
    SourceTable = "Hrm-Books Written";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(BookCode; Rec.BookCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BookCode field.';
                }
                field("Book Title"; Rec."Book Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Title field.';
                }
                field("No Of Book  Chapters"; Rec."No Of Book  Chapters")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No Of Book  Chapters field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }

            }
        }
    }
}
