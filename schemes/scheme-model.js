const db = require('../data/db-config.js');

module.exports = {
    find,
    findSteps,
    add,
    update,
    remove,
    addStep
};

function find(id) {
    if (id) return db('schemes').where("id", id).then(schemes => {
        if (schemes.length > 0) return schemes[0];
        else return null;
    });
    else return db('schemes');
}

function findSteps(id) {
    return db.column('steps.id', 'schemes.scheme_name', 'steps.step_number', 'steps.instructions')
    .select().from('steps')
    .innerJoin('schemes', 'schemes.id', 'steps.scheme_id')
    .where("scheme_id", id)
    .orderBy('step_number');
}

function add(data) {
    return db('schemes').insert(data, "id")
    .then(response => find(response[0]));
}

function update(data, id) {
    return db('schemes').where("id", id).update(data)
    .then(() => find(id));
}

function remove (id) {
    let data = {};
    find(id).then(response => {
        data = response;
    });
    return db('schemes').where("id", id).del()
    .then(response => data);
}
 
// `addStep(step, scheme_id)`: This method expects a step object and a scheme id. It inserts the new step into the database, correctly linking it to the intended scheme.

function addStep(data, scheme_id) {
    return db('steps').insert({
        scheme_id,
        ...data
    })
}