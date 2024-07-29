page 55137 "REG-File Requisition List"
{
    CardPageID = "REG-File Requisition";
    PageType = List;
    SourceTable = "REG-File Requisition";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Requesting Officer"; Rec."Requesting Officer")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Collecting Officer"; Rec."Collecting Officer")
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("File No"; Rec."File No")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("Authorized By"; Rec."Authorized By")
                {
                    ApplicationArea = All;
                }
                field("Served By"; Rec."Served By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

