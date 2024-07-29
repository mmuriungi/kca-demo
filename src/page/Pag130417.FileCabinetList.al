//was page 130417 "File Cabinet List"
page 55100 "File Cabinet List"
{
    CardPageID = "File Card";
    PageType = List;
    SourceTable = "File Cabinet";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Section Number"; Rec."Section Number")
                {
                    Caption = 'Section/Division';
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;

                }
                field(Abbrev; Rec.Abbrev)
                {
                    Caption = 'Abbreviation';
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;

                }
                field("File Subject"; Rec."File Subject")
                {
                    ApplicationArea = All;

                }
                field("File Index"; Rec."File Index")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }
}

