page 54357 "FLT-Transport Requisition Crd"
{
    PageType = Card;
    SourceTable = "FLT-Transport Requisition";
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            Group("PART ONE: APPLICANT")
            {
                field("Transport Requisition No"; Rec."Transport Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Requisition No field.';
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Request field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Emp No"; Rec."Emp No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Emp No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Purpose of Trip"; Rec."Purpose of Trip")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purpose of Trip field.';
                }
                field("Date of Trip"; Rec."Date of Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Trip field.';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
            }
            Group("PART TWO: HEAD OF DEPARTMENT/FACULTY/SECTION")
            {
                field("Recommed this Request"; Rec."Recommed this Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recommed this Request field.';
                }
                field("Recommendation Reason"; Rec."Recommendation Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recommendation Reason field.';
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD Name field.';
                }
                field("HOD UserName"; Rec."HOD UserName")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD UserName field.';
                }
            }
            group("PART THREE: TRANSPORT AND OPERATIONS OFFICER")
            {
                field("Mileage Before Trip"; Rec."Mileage Before Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mileage Before Trip field.';
                }
                field("Time out"; Rec."Time out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time out field.';
                }
                field("Total Mileage Travelled"; Rec."Total Mileage Travelled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Mileage Travelled field.';
                }
                field("Cost Per Kilometer"; Rec."Cost Per Kilometer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Per Kilometer field.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Cost field.';
                }
                field("Fuel Unit Cost"; Rec."Fuel Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fuel Unit Cost field.';
                }
                field("Transport Available/Not Av."; Rec."Transport Availability.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Available/Not Av. field.';
                }
                field("Reg. No."; Rec."Reg. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reg. No. field.';
                }
                field("Milleage after Trip"; Rec."Milleage after Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Milleage after Trip field.';
                }
            }
            group("PART FOUR: ADMINISTRATION AND CENTRAL SERVICES")
            {

                field("Approved/Not Approved"; Rec."Approved Request ?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved/Not Approved field.';
                }
                field("Admin Head Name"; Rec."Admin Head Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Admin Head Name field.';
                }
                field("Admin Head Username"; Rec."Admin Head Username")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Admin Head Username field.';
                }
            }
            part(Control29; "FLT-Transport Requisition St")
            {
                SubPageLink = "Req No" = FIELD("Transport Requisition No");
                ApplicationArea = All;
            }
        }

    }
    var
        group2: Boolean;

    procedure Group2Visible()
    begin
        group2 := true;

    end;
}