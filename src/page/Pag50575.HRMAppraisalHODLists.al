page 50575 "HRM-Appraisal HOD Lists"
{
    Caption = 'Appraisal list';
    CardPageID = "HRM-Appraisal Supervisors";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "HRM-Employee C";
    //SourceTableView = WHERE(Lecturer=FILTER(Yes));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("ID Number"; Rec."ID Number")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Postal Address"; Rec."Postal Address")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(County; Rec.County)
                {
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                }
                field("Ext."; Rec."Ext.")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Residential Address"; Rec."Residential Address")
                {
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                }
            }
        }
    }

    actions
    {
    }
}

