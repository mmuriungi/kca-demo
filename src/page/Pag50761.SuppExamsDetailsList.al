page 50761 "Supp. Exams Details List"
{
    PageType = List;
    SourceTable = "Aca-Special Exams Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("CAT Marks"; Rec."CAT Marks")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Exam Marks"; Rec."Exam Marks")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Marks"; Rec."Total Marks")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cost Per Exam"; Rec."Cost Per Exam")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    //Editable = false;
                    ApplicationArea = All;
                }
                field("Current Academic Year"; Rec."Current Academic Year")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Current Semester"; Rec."Current Semester")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Caption = 'Unit Academic Year';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Unit Semester';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    Caption = 'Unit Programme';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    Caption = 'Unit Stage';
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

