function splitSignature(sig) {
    // Remove '0x' prefix if it exists
    const cleanSig = sig.startsWith('0x') ? sig.slice(2) : sig;

    if (cleanSig.length !== 130) {
        throw new Error("Invalid signature length. Expected 65 bytes (130 hex characters).");
    }

    // Slice the string into r, s, and v
    const r = "0x" + cleanSig.slice(0, 64);
    const s = "0x" + cleanSig.slice(64, 128);
    const v_hex = "0x" + cleanSig.slice(128, 130);
    
    // Convert v from hex string to decimal integer (e.g., "1b" -> 27)
    const v_decimal = parseInt(v_hex, 16);

    console.log("--- Signature Breakdown ---");
    console.log(`r: ${r}`);
    console.log(`s: ${s}`);
    console.log(`v (Hex): ${v_hex}`);
    console.log(`v (Decimal): ${v_decimal}`);
    
    return { r, s, v: v_decimal };
}


const mySignature = "0xa0a69cb0fc3b9a8e4a974a330236d39601e432eaf43e53f47882417f48e6230f36483f4478d74a50ebf7467e3d19236f98cbb501aa7ae1c91e5705237ab286581b";

splitSignature(mySignature);
