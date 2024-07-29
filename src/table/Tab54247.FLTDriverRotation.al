table 54247 "FLT-Driver Rotation"
{

    fields
    {
        field(1; "Rotation No"; Code[20])
        {
        }
        field(2; "Date of Rotation"; Date)
        {

            trigger OnValidate()
            begin
                fleetmgt.Get;
                fleetmgt.TestField("Fuel Payment Batch No");
                "Next Rotation Date" := CalcDate(fleetmgt."Fuel Payment Batch No", "Date of Rotation");
            end;
        }
        field(3; "Next Rotation Date"; Date)
        {
        }
        field(4; "Created By"; Code[20])
        {
        }
        field(5; Closed; Boolean)
        {
        }
        field(6; "No. Series"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Rotation No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Rotation No" = '' then begin
            fleetmgt.Get;
            fleetmgt.TestField("Rotation Interval");

            // NoSeriesMgt.InitSeries(fleetmgt."Rotation Interval",xRec."No. Series",0D,"Rotation No","No. Series")

        end;

        //Get all Drivers
        Drivers.Reset;
        Drivers.SetRange(Drivers.Active, true);
        if Drivers.Find('-') then begin
                                      repeat
                                          DriverLines.Reset;
                                          DriverLines.SetRange(DriverLines."Rotation No", "Rotation No");
                                          DriverLines.SetRange(DriverLines.Driver, Drivers.Driver);
                                          if not DriverLines.Find('-') then begin
                                              DriverLines."Rotation No" := "Rotation No";
                                              DriverLines.Driver := Drivers.Driver;
                                              DriverLines.Validate(Driver);
                                              DriverLines.Insert;

                                          end;
                                      until Drivers.Next = 0;
        end;
    end;

    var
        fleetmgt: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Drivers: Record "FLT-Driver";
        DriverLines: Record "FLT-Driver Vehicle";
}

