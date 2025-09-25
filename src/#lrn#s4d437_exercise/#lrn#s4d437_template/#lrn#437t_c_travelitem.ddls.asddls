@EndUserText.label: 'Flight Travel Item (Projection)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity /LRN/437t_C_TravelItem
  provider contract transactional_query
  as projection on /LRN/437t_R_TravelItem
  {
    key ItemUuid,
        AgencyId,
        TravelId,

        @Consumption.valueHelpDefinition:
                [ { entity: { name:    '/DMO/I_Carrier_StdVH',
                              element: 'AirlineID'
                            }
                  }
                ]
        CarrierId,

        @Consumption.valueHelpDefinition:
                 [ { entity: { name:    '/DMO/I_Connection_StdVH',
                               element: 'ConnectionID'
                             },
                     additionalBinding:
                          [ { localElement: 'CarrierID',
                                   element: 'CarrierID',
                                     usage: #FILTER_AND_RESULT
                            }
                          ],
                     label: 'Value Help by Connection'
                   },
                   { entity: { name:    '/DMO/I_Flight_StdVH',
                               element: 'ConnectionID'
                             },
                     additionalBinding:
                          [ { localElement: 'CarrierID',
                              element:      'CarrierID',
                              usage:        #FILTER_AND_RESULT
                            },
                            { localElement: 'FlightDate',
                              element:      'FlightDate',
                              usage:         #RESULT
                           }
                         ],
                     label: 'Value Help by Flight',
                     qualifier: 'Secondary Value help'
                   }
                 ]
        ConnectionId,

        @Consumption.valueHelpDefinition:
             [ { entity: { name:    '/DMO/I_Flight_StdVH',
                           element: 'FlightDate'
                         },
                 additionalBinding:
                      [ { localElement: 'CarrierID',
                          element:      'CarrierID',
                          usage:         #FILTER_AND_RESULT
                        },
                        { localElement: 'ConnectionID',
                          element:      'ConnectionID',
                          usage:        #RESULT
                        }
                      ]
               }
             ]
        FlightDate,
        BookingId,
        PassengerFirstName,
        PassengerLastName,
        ChangedAt,
        ChangedBy,
        LocChangedAt
  }
