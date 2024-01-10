# README

# Models
1. User
2. DynamicField
3. DynamicValue
4. Option


```ruby
user = User.create(name: "test_user", email: "test_user@gmail.com")
user.dynamic_fields.create(name: 'personalities', value_type: 'string')
user.dynamic_fields.create(name: 'age', value_type: 'number')
user.dynamic_fields.create(name: 'gender', value_type: 'select', options_attributes: [ { label: 'male' }, { label: 'female' } ] )
user.dynamic_fields.create(name: 'hobbies', multiple: true, value_type: 'select', options_attributes: [{ label: 'running' }, { label: 'swimming' }, { label: 'hiking' }])
```

```ruby
#first time to initialize dynamic values:
{
  "user": {
    "name": "user",
    "dynamic_fields_attributes": [
        { "id": 1, "dynamic_values_attributes": [{ "string_value": "dark eyes" }] },
        { "id": 2, "dynamic_values_attributes": [{ "number_value": 123 }] },
        { "id": 3, "dynamic_values_attributes": [{ "select_value": 1 }] },
        { "id": 4, "dynamic_values_attributes": [{ "select_value": 3 }, { "select_value": 4 }] },
    ]
  }
}

#after we can update them:
{
  "user": {
    "name": "user",
    "dynamic_fields_attributes": [
        { "id": 1, "dynamic_values_attributes": [{ "id": 1,"string_value": "blue eyes" }] },
        { "id": 2, "dynamic_values_attributes": [{ "id": 2, "number_value": 123 }] },
        { "id": 3, "dynamic_values_attributes": [{ "id": 3, "select_value": 2 }] },
        { "id": 4, "dynamic_values_attributes": [{ "id":4, "select_value": 3 }, { "id": 5, "select_value": 4 }] }
    ]
  }
}
```

# Important Note
1. I don't really had time so I skip rubocop, rspecs(which means I probably could miss smth) and all good practices
2. Probably not the best model to handle dynamic fields. I thought about jsonb as simpliest solution, but also to split "DynamicValue" field into 3 separate or to use STI in order to make in DRY. Might be that there is some magic GEM which I could use.
3. Tried to make is clean as much is possible and not to overcomplicate.