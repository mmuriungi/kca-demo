page 52178596 "Proc-Committee Members"
{
    Caption = 'Committee Members';
    PageType = ListPart;
    SourceTable = "Proc-Committee Members";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Committee; Rec.Committee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Committee field.';
                }
                field("Member Type"; Rec."Member Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Type field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.';
                    TableRelation = if ("Member Type" = filter(Staff)) "HRM-Employee C"."No." where(Status = filter(Active)) else
                    if ("Member Type" = filter("Non Staff")) "Proc-Non Staff Committee".No;
                    trigger OnValidate()
                    begin
                        Hremp.Reset();
                        Hremp.SetRange("No.", rec."Member No");
                        if Hremp.Find('-') then begin
                            rec.Name := Hremp."First Name" + ' ' + Hremp."Middle Name" + ' ' + Hremp."Last Name";
                            rec.Email := Hremp."Company E-Mail";
                            rec."Phone No" := Hremp."Work Phone Number";
                            rec."Phone No" := Hremp."Home Phone Number";
                        end;
                        Nonstaff.Reset();
                        Nonstaff.SetRange(No, rec."Member No");
                        if Nonstaff.Find('-') then begin
                            rec.Name := Nonstaff.Name;
                            rec.Email := Nonstaff.Email;
                            rec."Phone No" := Nonstaff.Phone;
                        end;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Role field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No field.';
                }
            }
        }
    }
    var
        Hremp: Record "HRM-Employee C";
        Nonstaff: Record "Proc-Non Staff Committee";
}
