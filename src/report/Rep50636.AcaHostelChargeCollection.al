report 50636 "Aca-Hostel Charge Collection"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Aca-Hostel Charge Collection.rdl';

    dataset
    {
        dataitem("ACA-Students Hostel Rooms"; "ACA-Students Hostel Rooms")
        {
            DataItemTableView = WHERE(Billed = FILTER(true));
            column(SNo; "ACA-Students Hostel Rooms".Student)
            {
            }
            column(HNo; "ACA-Students Hostel Rooms"."Hostel No")
            {
            }
            column(RNo; "ACA-Students Hostel Rooms"."Room No")
            {
            }
            column(Sem; "ACA-Students Hostel Rooms".Semester)
            {
            }
            column(AYear; "ACA-Students Hostel Rooms"."Academic Year")
            {
            }
            column(Scharges; "ACA-Students Hostel Rooms".Charges)
            {
            }
            column(BDate; FORMAT("ACA-Students Hostel Rooms"."Billed Date"))
            {
            }
            column(SpaceNo; "ACA-Students Hostel Rooms"."Space No")
            {
            }
            column(pic; info.Picture)
            {
            }
            column(compName; info.Name)
            {
            }
            column(names; names)
            {
            }
            trigger OnAfterGetRecord()
            begin
                cust.Reset();
                cust.SetRange("No.", "ACA-Students Hostel Rooms".Student);
                if cust.Find('-') then begin
                    names := cust.Name;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
    trigger OnPreReport()
    begin
        if info.Get() then begin
            info.CalcFields(Picture);
        end;
    end;

    var
        cust: Record Customer;
        names: Text;
        info: Record "Company Information";

}

