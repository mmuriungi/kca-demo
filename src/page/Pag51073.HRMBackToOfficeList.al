page 51073 "HRM-Back To Office List"
{
    CardPageID = "HRM-Back To Office Form";
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Back To Office Form";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                }
                field("Course Title"; Rec."Course Title")
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field("Duration Units"; Rec."Duration Units")
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Training Evaluation Results"; Rec."Training Evaluation Results")
                {
                }
                field(Trainer; Rec.Trainer)
                {
                }
                field("Purpose of Training"; Rec."Purpose of Training")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Directorate; Rec.Directorate)
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Training Institution"; Rec."Training Institution")
                {
                }
                field("Training category"; Rec."Training category")
                {
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field(Station; Rec.Station)
                {
                }
                field("Training Status"; Rec."Training Status")
                {
                }
            }
        }
    }

    actions
    {
    }
}

