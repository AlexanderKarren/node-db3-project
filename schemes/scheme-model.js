const db = require('../data/db-config.js');

module.exports = {
    find,
    findSteps,
    add,
    update,
    remove
};

function find(id) {
    if (id) return db('schemes').where("id", id).then(schemes => {
        if (schemes.length > 0) return schemes[0];
        else return null;
    });
    else return db('schemes');
}

function findSteps(id) {
    return db('steps').where("scheme_id", id);
}

function add(data) {
    return db('schemes').insert(data);
}

function update(data, id) {
    return db('schemes').where("id", id).update(data);
}

function remove (id) {
    return db('schemes').where("id", id).del();
}