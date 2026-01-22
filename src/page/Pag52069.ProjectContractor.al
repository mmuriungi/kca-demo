page 52069 "Project Contractor"
{
    ApplicationArea = All;
    Caption = 'Project Contractor';
    PageType = ListPart;
    SourceTable = "Project Contractors";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("ID No"; Rec."ID No")
                {
                    ToolTip = 'Specifies the value of the ID No field.', Comment = '%';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the value of the Full Name field.', Comment = '%';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field(Company; Rec.Company)
                {
                    ToolTip = 'Specifies the value of the Company field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
            }
        }
    }
}
