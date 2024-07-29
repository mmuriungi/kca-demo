page 51812 "Special Exams Details List"
{
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Aca-Special Exams Details";
    SourceTableView = WHERE(Catogory = FILTER("Special"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Unit Code"; Rec."Unit Code")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
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
                field(Catogory; Rec.Catogory)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Current Academic Year"; Rec."Current Academic Year")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Caption = 'Unit Academic Year';
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Unit Semester';
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    Caption = 'Unit Programme';
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    Caption = 'Unit Stage';
                    Editable = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

