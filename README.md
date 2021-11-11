# Best Available Seat

### Running

#### JSON file
Create a json file that describes the venue and available tickets that is consisten with the following schema:
```json
{
  "venue": {
    "layout": {
      "rows": 10,
      "columns": 50
    }
  },
  "seats": {
    "a1": {
      "id": "a1",
      "row": "a",
      "column": 1,
      "status": "AVAILABLE"
    },
    "b5": {
      "id": "b5",
      "row": "b",
      "column": 5,
      "status": "AVAILABLE"
    },
    .
    .
    .        
  }
}

```
#### Executing the command

The command should be run from the root level.

Specify the input file that describes the venue with the `-i` flag and query how many tickets that are desired using the `-n` flag.  For example:

```
ruby ./app.rb -i ./sample_1.json -n 2
```

The above command will use the `sample_1.json` file and request `2` tickets.  