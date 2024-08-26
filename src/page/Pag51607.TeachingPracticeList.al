page 51607 "Teaching Practice List"
{
    Caption = 'Teaching Practice List';
    CardPageId = "Teaching Practice Card";
    PageType = List;
    SourceTable = "Teaching Practice Header";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.', Comment = '%';
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year of Study field.', Comment = '%';
                }
                field(School; Rec.School)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Category of School"; Rec."Category of School")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category of School field.', Comment = '%';
                }
                field("Subjects Taught"; Rec."Subjects Taught")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subjects Taught field.', Comment = '%';
                }
                field("Perriod of TP"; Rec."Perriod of TP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Perriod of TP field.', Comment = '%';
                }
            }
        }
    }
}
