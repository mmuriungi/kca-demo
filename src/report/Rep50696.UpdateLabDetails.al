report 50696 "Update Lab Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LabUpdateReport.rdl';

    dataset
    {
        dataitem(clinic; "HMS-Treatment Form Header")
        {

            column(TreatmentNo_clinic; "Treatment No.")
            {
            }
            column(TreatmentType_clinic; "Treatment Type")
            {
            }
            column(TreatmentDate_clinic; "Treatment Date")
            {
            }
            column(TreatmentTime_clinic; "Treatment Time")
            {
            }
            column(DoctorID_clinic; "Doctor ID")
            {
            }
            trigger OnAfterGetRecord()
            begin
                clinic2.Reset();
                clinic2.SetRange("Treatment No.", clinic."Treatment No.");
                clinic2.SetRange("Patient No.", clinic."Patient No.");
                if clinic2.Find('-') then begin
                    // repeat
                    labry.Reset();
                    labry.SetRange("Patient No.", clinic2."Patient No.");
                    //  labry.SetRange("Date Due", clinic2."Treatment Date");
                    if labry.Find('-') then begin
                        repeat
                            /* if labry."Patient No." <> clinic2."Patient No." then begin
                                labry."Patient No." := clinic2."Patient No.";
                                labry.Modify(true);
                            end; */
                            if labry."Treatment No." <> clinic2."Treatment No." then begin
                                labry."Treatment No." := clinic2."Treatment No.";
                                labry.Modify(true);
                            end;

                        until labry.Next() = 0;
                    end;
                    // until clinic2.Next() = 0;
                end;

            end;
        }
    }

    var
        labry: Record "HMS-Treatment Form Laboratory";
        clinic2: Record "HMS-Treatment Form Header";
}