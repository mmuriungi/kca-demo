page 52178593 "Proc-Non Staff Committee"
{
    Caption = 'Proc-Non Staff Committee';
    PageType = List;
    SourceTable = "Proc-Non Staff Committee";
    InsertAllowed = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone field.';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field("Institution From"; Rec."Institution From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution From field.';
                }
            }
        }
    }
}
